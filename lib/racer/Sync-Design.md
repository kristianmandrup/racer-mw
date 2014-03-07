# The Gateway to Racer

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