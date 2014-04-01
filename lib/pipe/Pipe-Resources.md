## Pipes and Resources

This section contains a brief overview on how Pipes relate to Resources.
Pipes are mostly "intelligent" wrappers for the Path part of the Racer model API.
A pipe has access to its resource through the special `$resource` property

```livescript
user-resource = user-pipe.$resource

# apply some commands on the resource
```

The pipes pass any value assigned to its resource. The Resource is responsible for syncing the value
 with the Racer data layer (and underlying data store).

The Resource has access to its Pipe container via the `$pipe` property.

```livescript
user-pipe = user-resource.$pipe
```

The Resource uses its pipe internally in order to know where in the Racer model to sync the data.
The pipe is the "path part" of the resource.

The Resource can execute all of the Racer commands that apply for the kind of value it holds (collection, model or attribute).
A Resource can be any of:

- Collection
- Model
- Attribute

Each Resource inherits from `BaseResource` which contains common functionality shared by any resource.

Each type of Resource can only execute a subset of commands, those commands that are valid for the kind
 of value that it is responsible for syncing with *Racer*.

An `Attribute` resource can't execute a collection specific command on its attribute and vice versa.
From this it follows that a pipe can only execute the commands exposed by its resource.

All resources have a `$save` command which simply saves (sets) the current value of the resource to
 the path location defined by the pipe.

`user-pipe.$resource.$save()`

A shorthand `$res` is also available: `user-pipe.$res.$save()`

A shorthand of the `$resource` API is provided as a convenience. You can simply use `$<command>` directly on a pipe.

`user-pipe.$save()`

Setting the user model value to another user is a valid model command.

```livescript
user-pipe.$set emily
```

Inserting a string on a collection is invalid however (and made impossible).

```livescript
users-pipe.$resource.string-insert ...

=> Error
```

For more details on how to use Resources and some of the internal Resource machinery, see the **Resource doc**
in this project (lib/resource folder).