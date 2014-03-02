# Resource Design

An overview of the Resource design

## Resources

Resources can either be used standalone or contained within pipes.

A *pipe* is an abstraction of the "path" to a data node in the underlying (JSON) data model synchronized by the *Racer*
Real-Time sync engine.

## Types of Resources

A Resource can be any of:

- Collection
- Model
- Attribute

Each Resource inherits from `BaseResource` which contains common functionality shared by any resource.

## Stand-alone resource

If you use a resource "stand alone" you need to specify the path where resource belongs manually:

`resource.path = 'users.1'`

When path is set, the Resource `full-path()` function will use the resource `path` otherwise it will look for the
path on the pipe (see below). When a resource path is set explicitly you can use a stand-alone resource
just the same as if it was associated with a pipe:

```livescript
resource.$set emily
```

## Pipe resource

A pipes passes any value it is assigned to its resource. The Resource is responsible for syncing the value
 with the Racer data layer (and underlying data store).

The Resource has access to its Pipe container via the `$pipe` property.

```livescript
user-pipe = user-resource.$pipe
```

When a resource is linked to a pipe, the resource `full-path` will be calculated by retrieving `pipe.full-path`

```livescript
resource.$set emily
```

When a pipe is assigned a value, it will be set on the resource of the pipe. This means, that if a resource is ever
 detached from a pipe, it still contains its own value. On the other hand, if the pipe is reattached to a new resource
 it has no memory of its old value but gets access to the new resource value.

### Attach & Detach

A resource can detach from its pipe by calling the `detach()` function.

```livescript
resource.detach()
resource.$pipe # => undefined
```

You can also attach a resource to a new pipe using `attach-to`:

```livescript
resource.attach-to(pipe)
```

## Resource commands

Each type of Resource can only execute a subset of commands, those commands that are valid for the kind
 of value that it is responsible for syncing with *Racer*.

An `Attribute` resource can't execute a collection specific command on its attribute and vice versa.
From this it follows that a pipe can only execute the commands exposed by its resource.

All resources have a `$save` command which simply saves (sets) the current value of the resource to
 the path location defined by the pipe.

## Base resource

Any resource has the following "base" functionality.

**resource-type**

`resource.resource-type` returns the type of resource, f.ex `'model'` for a `ModelResource`.

**save**

Any resource has a `save` method. Save can be used at any time save sync the current value to Racer.

`resource.$save()` saves the current resource value using Racer `set(value)`.

**commands**

Any resource has a `commands` property which contains the commands that can be executed by that command,
grouped by type of command:

* basic
* scope
* number
* string

*Basic* commands are the most "basic" commands that are common to all types of resources, such as `at`, `path` and `scope`.

*onScope* : commands that operate on a scope. A scope is used for chaining several commands.

A resource will internally maintain and store a `scoped` variable after each scope command which is used to
facilitate this scope chaining.

*setNumber* : commands that set Numbers, such as `increment`.

*setString* : commands that set Strings, such as `string-insert`.

*setScope* commands that set the scope with the result of the command.

The commands exposed by any resource are generated dynamically based on the `commands` property.
The `CommandBuilder` is responsible for this job.

The `Filtering` module contains specific commands for querying and filetering.
Each of these commands are of the type `create`, which means that will create new Resource wrappers (such as a `Query` instance) for the
filtering result they return.

```
create:
  * 'query'   # new Query   @resource, @query
  * 'filter'  # new Filter  @resource, @filter
  * 'sort:filter'
```

### Command builder

The `resource/arg` folder contains json files for that declare the rules for each type of command.
Example `arg/basic`

```
set:
  required:
    * 'value'
  optional:
    * 'cb'
  result: 'previous' # previous value
```

This specifies that for the `set` command, `value` is a *required* argument and `cb` is optional.
The result of the command should be stored in a `previous` variable on the resource.

### Query

A query is a special Resource wrapped for the query command. Only specific query commands are made available on
the result of the query:

*on-query* : commands that can be run on a query result (`ref` and `get`)

### Filter

*on-filter* : commands that can be run on a filter result (`ref` and `get`)



## Marshalling

We have added a few `$` prefixed properties and methods to the Resouce model.
You don't want these values to be stored in the DB. So the marshalling (marshal-mw) should ensure that any `$` value
is always discarded and then they will be put back on by the Resource decorator :)
At least it should always discard `$resource` and `$pipe`.

### $set current model object as-is

set with current values

```livescript
$save: ->
  $set @
```

### $set model object

Perform should be responsible for generating the path to be used
It should first authorize, validate and marshal and then use $calc-path to
calculate the full path (via PathResolver)

```livescript
$set: (value-hash) ->
  @perform 'set', value-hash
```

### $set attribute with value

```livescript
$set: (attribute, value) ->
  vhash = {}; vhash[attribute] = value
  $set vhash
```

same as $set but using 'if-null' method, setting only if null (not present yet!)

```
$set-null: (attribute, value, opts) ->
  @perform 'if-null', ...
```

### $get model

Should first authorize, then decorate (if get value). Also allow subscript and live-update (ref)
See *CrudGet* ;)

```livescript
$get: (model)
  @perform 'get', @get-for(model)
```

### $get query

Query under current path..

```livescript
$get: (q: query)
  @perform 'get', query
``

### Delete

Should first authorize

```livescript
$delete: (path) ->
  @perform 'del'
```

## Extras

### $inc attribute

Should first authorize and validate (but only if container is synced?)

```livescript
$inc: (attribute, path) ->
  @perform 'increment', attribute
```

### $push model-obj

If parent is a collection. Note that `@value-object!` is necessary to get the real value, as we are calling
 from withing the context of a `Resource`.

```livescript
$push: ->
  @perform 'push', @value-object!
```

As we see here, path or perform should create a new Execution object,
decoupled from the Resource itself, only referencing it

Path coupled with the current path should add up to path that points to collection
If no value as 2nd arg, then use self (model obj)

```livescript
$push: (path) ->
  @path(path).perform 'push', @value-object!
```

If no value as 2nd arg, then push this

```livescript
$push: (path, value) ->
  @path(path).perform 'push', @value-object!
```

values can be a list of args or an array

```livescript
$push: (path, values) ->
  @path(path).perform 'push', values.flatten!.compact!
```

To avoid cluttering the model with all these Resource methods, we should have them in one place

```livescript
user = {
  $class: 'user'
  $res: ->
    @$resource ||= new Resource @
}

user.$res!.save!
user-res = user.$res!
user-res.save!
user-res.del!
```

or even

`res = $resource(user).$save!.has(email: email)`

Where `$resource` returns the resource of the user

## Resource: advanced chaining DSL

`$resource(user).$set(age: 27).$push('projects', project).$delete('project').from('archived-projects').where('oldest', 10)`

Let's attempt designing the Resource now!

```livescript
Resource = new Class(
  # value-object
  initialize: (@value-object)

  $save: ->
    @$set @value-object

  $set: ->
    # clever args handling...
)
```

We must combine multiple setters into one..

```livescript
  $set: (value-hash) ->
    @perform 'set', value-hash

  $set: (attribute, value) ->
    vhash = {}; vhash[attribute] = value
    $set vhash

  $set: ->
    #...
```

We can subclass `RacerSync` to get @perform, however subclassing is a little too "heavy-handed" as we get too much mixed into
the Resource. Baaad! Better to

```livescript
Resource = new Class(RacerSync,
  $set: ->
    @$scoped = switch arguments.length
    case 0
      @$set @value-object
    case 1
      @perform 'set', arguments[0]
    case 2
      vhash = {}
      vhash[arguments[0]] = arguments[1]
      @$set vhash
    default
      throw Error "Too many arguments #{arguments.length}, must be 0-2 for $set"
```

Better like this:

```livescript
Resource = new Class(
  sync: ->
    @my-sync ||= new RacerSync @

  perform: ->
    @sync!.perform arguments
```

Perhaps we could even use `Forwardable` from *jsclass* ?

Pure Awesomeness!!

## Live updates and subscriptions

And how about live updates (refs) and subscriptions to model change events?

Derby docs [subscriptions](http://derbyjs.com/#subscriptions)

The `subscribe`, `fetch`, `unsubscribe`, and `unfetch` methods are used to load and unload data from a model.
These methods don’t return data directly. Rather, they load the data into the model.
The data are then accessed via model getter methods.

`subscribe` and `fetch` both return data initially, but subscribe also registers with *PubSub* on the server to
receive ongoing updates as the data change.

```
model.subscribe ( items..., callback(err) )
model.fetch ( items..., callback(err) )
model.unsubscribe ( items..., callback(err) )
model.unfetch ( items..., callback(err) )
```

`items`: Accepts one or more subscribable items, including a path, scoped model, or query

`callback`: Calls back once all of the data for each query and document has been loaded or when an error is encountered

"subscribable items, including a path, scoped model, or query"

To make it easier, we should always return and use scoped models.

To access it `user.$resource.$scoped` or shortcut, simply `user.$scoped!`, same with `user.$alive` for the
live updated model.

```
user = {
  $scoped: ->
    $resource.$scoped
  $alive: ->
    $resource.$alive

  $resource:
    $perform: (action, path, args...) ->
      subject = if path then @$calc-path(path) else @$scoped
      @sync.perform action, subject, args

    update-model: (live-obj) ->
      new LiveDecorator(@value-object).decorate live-obj

    $alive: void
    $scoped: void
    $subscribe: (cb, path) ->
      @perform 'subscribe', path, cb

    # model.ref path, to
    $live: (path)->
        $alive = @perform 'ref', path
        @update-model($alive)

    $remove-live: (path) ->
      $alive = @perform 'refRemove', path

    $get: (path) ->
      @perform 'get', path

    $at: (id) ->
      @id ||= id
      throw Error "No id set for #{@collection}" unless @id
      @$scoped = @perform 'at', @id

    save: ->
      # ...

    $set: ->
      # ...
}
```

So now we can do `user.$resource.$subscribe` and have `scoped` models with *live update*.

Here is a simple (default) implementation of `LiveDecorator`, used to update the value-object
with the incoming "live data" from the data store.

```livescript
LiveDecorator = new Class(
  initialize: (@vo)

  decorate: (live-obj) ->
    lo.extend @vo, live-obj

)
```



## Resources that are not value objects

Note: A resource can also be part of a piped `collection`, `attribute` or `path`.
In that case it operates just the same, except there is no value-object for the resource.
Also there is no middleware stack. Thus it is a simple-resource.

## Reusable "smart" queries

Note this part:

`$delete('project').from('archived-projects').where('oldest')`

Here we are taking advantage of a named query.

```livescript
user.$resource.$queries.add = {
  oldest: -> {date: {$gte: Date() + days(3).before('today')} }
}

user.$resource.$queries =
  oldest: (num) ->
    {date: {$gte: Date() + days(3).before('today')} }.extend @limit(num)

  youngest(num): ->
    { $sort: {asc: 'age'} }.extend @limit(num)

  limit: (num) ->
    { $limit: num }
```

Pretty awesome!!!

Please add more thoughts/ideas... :)
