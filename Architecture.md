# Architecture

An overview of the architecture to be implemented.

## Racer

Racer already provides a very powerful model access API.
It employs the concept of paths to point to data-points in the model graph to act upon.
To allow reuse of these paths, it provides scopes which are entry points that can be reused for further action
via method chaining.

Set the first user, then go to 'admin' of that user, and set his name to 'Hansel'. Then get the name of the parent (admin).

`model.set('users.1', user).path('admin').set('name', 'Hansel).parent().get()`

However this API does not encapsulate any concept of types, such as Object, Collection and
simple Attributes (numbers, strings, dates, ...)

A richer API would provide such concepts and also encapsulate the paths.

```
user = $collection('users').$item('user', 1).set(user)
console.log user.get
user.$attribute(model: 'admin').$attribute(string: 'name).set('Hansel').parent().get()
```

The concept of Racer `scopes` already provides path building, by storing the current full path and appending a sub-path
 for each method chained. However these scopes are static, they are likely not dynamically calculated?
Would be nice if I could detach in the middle of a scope, apply another "scope" and have the full path still calculated
correctly. This is where the concept of a `Pipe` takes shape.
A `Pipe` is a class which provides dynamic path calculation and has the concepts of parent and children.
Pipes can be linear or form tree structure, just like the underlying data model.

A `Resource` is a data entity, either a `Collection`, `Model` or `Attribute`.

When a *query* is performed, a `Query` is returned. A query only allows the commands `get` to return the query result
and `ref` and to return a reference to the result (updated dynamically - useful for live updates!).

When a *filter* is performed, a `Filter` is returned. A filter only allows the commands `get` to return the filter result
and `ref` and to return a reference to the result.

```
Filter = new Class(ResourceCommand,
  initialize: (@resource, @filter) ->
  commands:
    filter:
      * 'ref'
      * 'get'
)
```

`Filter` and `Query` are very similar, however the query performs a native DB query, whereas a filter runs
a custom function on the result to `filter` or `sort` a collection.

For both filter and query, `ref` allows for subscribing to live updates of the result set.

Applying the concept of a Resource, we can enforce that any resource encapsulates its own path.
This means that any model command on a Resource will NOT take a `path`, as the path will instead be taken
from the Resource (dynamically calculated via a PathResolver from its parent pipes, all the way to the root.)
The path should only be calculated whenever the "pipeline" changes (a new pipe is added).
Each time the path should be cached.

If a pipe is detached from a pipeline, all its child pipes should have their path invalidated.
If the pipe is reattached to another pipeline, the pipe and all its children should recalculate their path and cache.

The Racer scope commands are those commands that return a scope. Each scope command should set an internal
`$scope` variable on the resource, but should return the resource itself for further chaining.
Any command that expects to be applied on a scope should simply apply on the current `$scope` value.

For commands such as `ìnsert` which returns the length of the collection after insert, will operate in a similar fashion.
An internal `length` attribute will be set and the Resource returned. At any time the last length can thus be accessed.

If a reference is set up on the collection however, it should invalidate or reset the length whenever
it is notified that the collection size is changed. This is left as a future enhancement (to be a feature?).

The Resource commands are all called using a hash syntax, like the following:

Racer command:

`model.refList ( path, collection, ids, [options] )`

Resource command:

```
  resource.refList collection: col, ids: my-ids
  resource.refList ids: my-ids, collection: col, options: {deleteRemoved: true}
```

This call is a little longer, but much clearer.

The benefits of the hash (Object) call approach are...

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

Sweet :)






