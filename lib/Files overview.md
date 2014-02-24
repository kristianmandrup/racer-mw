# Files overview

A brief overview of the file structure of this project...

## DSL

The main DSL of the app resides in `dsl.ls`. Here the following "global" functions are exported.

- path(path)
- collection(col-name)
- model(model-obj)

Each of these construct a `Pipe` you can use or start building on...
Any pipe has a `Resource` embedded which you can use to execute Racer commands.
The resource will also (often) have a value object attached, which is used to set the resource in the model store at the
path of the resource.

## Errors

The `errors` folder and `errors.ls` contains custom errors.

## Resource

All core Resource files reside in the `resources` folder. The following are the resources available.

- path
- collection
- model
- attribute

A PathResource is usually used to create a container object which is not a collection and not a model either, such as `_page`.
A CollectionResource can maintain a list of ModelResource objects (through its pipe).
A ModelResource can have AttributeResource resources (through its pipe).

The BaseResource contains base functionality for a Resource, such as access to the pipe and infrastructure services such as
the gateway to Racer store execution.

Filter and Query are special objects, returned by filter and query functions from Racer. Each provide a subset of functions available
for further chaining, such as `get` and `ref` that act on the result.

Queries contain a set of scoped queries for reuse (much like Rails "named scopes"). The ResourceCommand wraps a command ready for execution
on Racer (via sync).

## Racer

The `racer` folder...




