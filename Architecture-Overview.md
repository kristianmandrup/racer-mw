# Architecture

An overview of the architecture in place (and what remains to be implemented).

## Racer Model API

Racer provides a very powerful Model access API.

The Model API employs the concept of *paths* that point to a specific data-points (nodes) in the model graph.
An model command will use a path to determine where in the graph the operation takes place.

The commands are usually in mostly some sort of *CRUD* commands: Create, Readin, Update or Delete data.
However the API also supports moving/rearranging nodes in the graph. A move operation requires two paths, where to
move from and where to move to.

The model API allow reuse of paths by the way of scopes. A scopes is an "entry point" that can be reused for further action
via method chaining.

### Scope example

Set the first user, then go to 'admin' of that user, and set his name to 'Hansel'. Then get the name of the parent (admin).

`model.set('users.1', user).path('admin').set('name', 'Hansel).parent().get()`

## API limitations

The model API doesn't encapsulate any higher abstractions or *Type* information, such as Model, Collection and
simple Attributes (numbers, strings, dates, ...) that we normally work with in real ORMs or Data modelling in general.

It would be convenient to better encapsulate the paths so we don't have to memorize or pass around
the path for each operation on the same data point. Scopes are not really sufficient.

A higher level model abstraction would encapsulate the path within and also provide the concepts of Collection, Model and
Attributes to build real data models that are more strongly typed - i.e. so that we know that a certain node is expected to
contain a certain kind of data and only allows certain kinds of operations acted upon it. Each node should act as a Resource
and only allow a subset of operations according to the type of Resource. The Resource should know where to act by using
its encapsulated path.

## Pipes and Resources

The Racer abstraction framework provided by this library provides two main entities that work together:

- Pipe
- Resource

A `Pipe` is an abstraction over a path with the concepts of parent and child pipes.
A pipe can have a single parent but multiple children. Pipes can be used to build a single path or complete graphs.
It is recommended to use pipes to reflect the entire underlying data model. Pipes are the main building blocks.

The underlying graph model is a JSON structure where each object is a *Document*. It is usually convenient that certain
Documents follow specific conventions and have a certain kind of *Schema* so that there is some control of what kind of data
can be expected at each data point.

This is where the concept of a Model gains importance. A Model acts as a kind of schema for a Document in the data model.
It defines the rules for how to operate on said document.

It is often the case that some nodes contain a list of multiple Documents of the same type.
These nodes are called collections. A Collection is an abstraction over such list nodes and ensures that there are certain
rules for the operations on the collection of models (Documents).

A Model can have one or more properties. Each property can be either:

- a Collection of models
- a Model
- an Attribute (simple values)

Each Pipe is connected to a Resource of the same type and the Resource is also connected to the pipe.
Any resource command always knows where in the graph it should apply the command.
It can set its own path directly (if stand-alone), but moe commonly it gets the path information from its pipe.

Depending on the type of Resource, only a subset of operations are available that makes sense for that kind of resource.
Attribute operations don't apply for a Collection, and Collection operations don't make sense for an attribute.

**Note: Much of the following should go into the Resource-Design document!?**

## Issuing commands

A Racer model API command is of the following form.

`model.refList ( path, collection, ids, [options] )`

The Resource commands are instead all called using a hash syntax, like the following:

```
  resource.refList collection: col, ids: my-ids
  resource.refList ids: my-ids, collection: col, options: {deleteRemoved: true}
```

This call is a little longer, but much clearer.

The benefits of the hash (Object) call approach are:

- easier to remember parameter names than calling order
- clearer code
- flexible parameter order

Additionally we can use the parameter names for better error messages and greatly simplify the code base.
The `lib/resource/arg` contains the code that handles all this.

The arg files such as `array.ls` simply contains json which defines which arguments are required and optional
for a given "array" command, and (optioanlly) in which variable it should store the result on the resource.
Given that we always have the arguments as a hash, we can simply look up these rules in the `ArgValidator`.
We can then validate accordingly and provide clear error messages to the user:

- there are argument names outside the required and optional
- one or more required arguments have not been assigned in the call

The error message can even respond with the required and optional arguments for the command as part of the error message!
A much nicer developer experience :)

As a further bonus each command can be simplified to the following blueprint signature:

```
<command-name>: (hash) ->
  @perform '<command-name>', hash
```

Since all commands will be able to follow this simple common signature, we can auto-generate the command functions
from a simple list of commands allowed for the Resource in question.

```
commands:
  * 'get'
  * 'set'
  * 'set-null'
```

Some commands are applicable for all Resources, whereas others such as the Array methods,
only make sense for a `CollectionResource`.

To further take advantage of this, some methods are scoped, ie. they should set the `scope` variable with the result.
We can simply wrap the command in a scoped function like this:

```
scoped: (hash) ->
  @scope = (@perform '<command-name>', hash)
  @

<command-name>: (hash) ->
  @scoped '<command-name>', hash
```

## The Gateway to Racer

the `RacerSync` class is meant as the gateway to the *Racer store*.
It needs some redesign. Starting from scratch!
The new command `CrudMap` will be used to return a middleware stack suitable for a given racer store command.

```
# CrudMap
  read:
    * get
    ...
  update:
    * 'set'
    * 'inc'
    * 'string-insert'
    ...
  delete:
    * 'del'
    * 'unshift'
    * 'pop'
    * 'remove'
   ...
```

`RacerSync` should expect to be called with a `RacerCommand` which contains the `name` of the command
(name of function on racer store model) the `arguments` and the middleware `stack` to be used.
`RacerSync` is then responsible for assembling the final and execution (via the stack),sending the
final command (potentially with marshalled value) to the racer model store for execution.

The `RacerCommand` will get a `resource` and a valid `hash` (Object) of arguments for the command.
It will unpack these correctly for the command (using another lookup map for the argument sequence).
It should use the `@resource.scope` if one is present, and otherwise
use the `@path` of the `@resource`.

## ResourceCommand

Current design:

```
  sync: ->
    @my-sync ||= new RacerSync @

  get-path: ->
    @resource.pipe.get-path! # calculate or get cached ;)

  perform: (action, hash) ->
    @sync.perform action, @get-path!, hash
    @

  scoped: (command, hash) ->
    @scope = @perform command, hash
```

As we can see, this step:

```
  perform: (command, hash) ->
    @sync.perform action, @get-path!, hash
```

Needs to be refactored to something like:

```
  # args example:
  # ‘push’, object: value, cb: cb-fun
  perform: (action, hash) ->
    # save last executed command, just coz we can ;)
    @command = new RacerCommand(@resource).run(action).with hash
    @excute @command

  execute: (racer-command) ->
    @racer-sync.execute racer-command
```

`RacerCommand` and `RacerSync` can be developed stand-alone from the above "design spec".

With respect to using Pipes:

```
user = {
  name ‘kris’
  _clazz: ‘user’
}

user-pipe = $model(user).save!
```

Should under the covers do something like

Create a pipe `collect(‘users’).model(user)` since `user` has the `_clazz` attribute `_clazz: 'user'`.
The pipe will then have the full path `users.1` (or similar: `id` as GUID from `model.id()` ?)
Then `save` will call `model.set(path, user)` and execute the 'update' crud middleware stack.

- authorization via `current_user.can 'update', user`,
- validation (look up validator via user `_clazz: 'user'`)
- marshalling (look up marshaller by class).

A lot of “magic” under the covers…

Finally we can subscribe on the user and get the updated real-time results decorated if we like.
Decoration auto-creates a "Class" for each user loaded from the model, by looking up Decorator via class.

Something like this?

```
user-pipe.subscribe (err) ->
  return next(err) if (err)
  result := user-pipe.decorated!
```

Sweet :)







