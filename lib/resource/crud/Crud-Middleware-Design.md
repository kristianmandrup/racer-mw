# Crud Middleware Design

The Crud Middleware is an optional layer that can be used to inject functionality into the process that occurs
 when a resource:

* executes a new command on Racer
* retrieves a new value from Racer

Commands can be grouped into the following conventional CRUD categories

* Create
* Read
* Update
* Delete

Create is not really part of the Racer command set. Racer just sets the data at the specified path, overwriting any existing value
 or "creating" a new value if none is present. So really, a command is one of the following RUD:

* Read
* Update
* Delete

*Read* commands can be set up to `authorize` the user to read the data (input) and `decorate` the object read (output).

*Update* commands modify the data in some way. The middleware can be set up to *authorize* if user may
perform an update of the specific data (or even execute the specific racer command).

The middleware can also be set up to *validate* the data, usually the data being set but
potentially also if the data is valid within a certain "data scope" (such as the containing model or collection etc.).

*Delete* commands remove data and the command can be authorized. Potentially the "data scope" (container) could also
validate if the new data after removal would be valid within the containment scope.

## Crud map

The `crud_map` file contains a JSON structure that declarative groups each command into one of the RUD types.

```
module.exports =
  read:
    * 'get'
    ...
  update
    * 'set'
    * 'inc'
    ...
```

This map is used by the `CrudMwFactory` to build the right middleware stack for each command.

## Crud middleware

The `CrudMwFactory` is used to create the CRUD middleware for a command, based on what kind of RUD command it is.

The `build` function build the middleware based on the `CrudMwFactory` constructor arguments passed in.

## Enable/Disable

It is easy to disable all or parts of the middleware for any resource.

```livescript
users-col.$mw.off! # turn all mw off
users-col.$mw.on! # turn all mw on

# turn off validation
users-col.$mw.off 'validation'
users-col.$mw.off 'validate', 'authorize'
users-col.$mw.on 'validate'
```

## The usual suspects

Most commands contain one or more of the following typical middleware components:

* Authorization
* Validation
* Marshalling
* Decorator

By default, all the components are taken from the *middleware*  project. However you are free to roll your own
or integrate your own authorization, validation etc. into the *middleware* stack.

Currently these components only operate on a single item at a time. It would be interesting to see an optimization
for authorizing, validating etc. a collection/list of items.

## Authorization

For authorization the list of parents is part of the context in which to authorize in.
The permit (or other authorization) is then free to use this information.

The authorization middleware will execute the following kind of logic:

`can 'add', data: value, ctx: {container: container, attribute: attribute}`

See the **authorize-mw** project.

## Validation

The validation could take the container object, the attribute and the item obj and validate whether
the container obj allows this item obj to be inserted into the list.

This could be based either on the type of container and item object or even on the state of the container object (which
could be set up to live-update subscribe to changes in the model).

Internally something like the following should be going on in the middleware pipeline:

`validate container: container, attribute: attribute, data: data`

Of course this could later be optimized to a nicer DSL if need be

`validate-on(user).add("#{attribute}": data)`


