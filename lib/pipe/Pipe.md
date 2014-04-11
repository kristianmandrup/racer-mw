# Pipe Design

Introduction and overview of Pipes.

## What are pipes?

Pipes are the main building blocks. It is simply a more intelligent, more functional,
more data carrying information layer that abstracts your hierarchical JSON data model into logical OOP entities such as:

- Path
- Collection
- CollectionModel
- AttributeModel
- Attribute

The pipes can be grouped into:
- Container pipes
- Child pipes
- Named pipes

### Container pipes

Container pipes can be parents of other pipes (can have child pipes).
The following container pipes are available:

- Path
- Collection
- CollectionModel (Model)
- AttributeModel (Model)

These pipes all include the `ContainerPipe` module.
Every container can also be a Child pipe, and so also include the Child pipe module.

### Child pipes

Child pipes can be children of other pipes. The Attribute pipe is a special child pipe since it cannot be a Container.
- Attribute

Child pipes include the `ChildPipe` module.

Every Pipe inherits from `BasePipe` for basic pipe functionality.

### Named pipes

Named pipes are any pipes that can be a named child of a parent pipe that is not a collection.
The following pipes are Named pipes and include the NamedPipe module:

* Attribute (simple values)
* AttributeModel
* Collection (of models)

### Path

A `Path` is a simple wrapper for a path in underlying data model. A Path pipe should only be
used when you want to avoid/disregard part of the data model for abstraction.
This would typically be when you are introducing this abstraction framework on an existing data model
 and want to introduce the abstraction layer step-by-step. Another reason could be that part of the data model
 is already abstracted (or taken care of) by some other logic or abstraction layer.

In any case, a Path pipe is just a thin wrapper over a path which allows you to pipe from that path and on.

A Path pipe can:
- have Attribute pipes as children.
- be assigned a value, but since it is not a "real" data abstraction this is generally discouraged.

### Model

A Model is a wrapper for a `Document`. A model should have a class such as `User`.
A `Model` can have one or more Attribute pipes as children, which can be any of:

* `Attribute` (simple values)
* `AttributeModel`
* `Collection` (of models)

A Model pipe can be either a `CollectionModel` (when child of a collection) or a `AttributeModel` when acting as an
Attribute on a parent pipe.

There are two kinds of Model:

* AttributeModel (a NamedPipe, can be used as an attribute on another Model)
* CollectionModel (an UnnamedPipe, can be added to a Collection)

### Attribute

An `Attribute` is a wrapper for a simple value (or values), such as:

* `String` (text)
* `Number`
* `Date`

It can also contain a list of simple values in an `Array`.

### Collection

A `Collection` can have one or more `CollectionModel` as children, usually of the same kind.
Typically, a `Users` collection would contain `User` Model pipes.
