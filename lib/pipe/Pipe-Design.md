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
- non-Container pipes


Container pipes can be parents and have child pipes, they are:
- Path
- Collection
- CollectionModel
- AttributeModel

The pipes all inherit from `ContainerPipe`.

Child pipes that cannot be parents and cannot have children but are always children of some other pipe:
- Attribute

These pipes inherit from `ChildPipe`.

Both `ContainerPipe` and `ChildPipe` inherit from `BasePipe` which has the most basic pipe functionality common to all pipes.

Attribute pipes are any pipes that can be a named child of a parent pipe that is not a collection.
The following pipes can act as Attribute pipes:

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

### Attribute

An `Attribute` is a wrapper for a simple value (or values), such as:

* `String` (text)
* `Number`
* `Date`

It can also contain a list of simple values in an `Array`.

### Collection

A `Collection` can one or more `CollectionModel`, usually of the same kind.
Typically, a `Users` collection would contain `User` objects.

