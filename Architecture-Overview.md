# Architecture

An overview of the architecture in place (and what remains to be implemented).

## Racer Model API

Racer provides a very powerful Model access API.

The Model API employs the concept of *paths* that point to a specific data-points (nodes) in the model graph.
An model command will use a path to determine where in the graph the operation takes place.

The commands are usually in mostly some sort of *CRUD* commands: Create, Readin, Update or Delete data.
However the API also supports moving/rearranging nodes in the graph. A move operation requires two paths, where to
move from and where to move to.

The model API allow reuse of paths by the way of scopes. A scope is a Racer model "entry point" that can be reused for further action
via method chaining.

### Scope example

Set the first user, then go to 'admin' of that user, and set his name to 'Hansel'. Then get the name of the parent (admin).

`model.set('users.1', user).path('admin').set('name', 'Hansel).parent().get()`

## API limitations

The model API doesn't encapsulate any higher abstractions or *Type* information, such as *Model*, *Collection* and
*Attributes* (numbers, strings, dates, ...) that we normally work with in real ORMs or Data modelling in general.

It would be convenient to better encapsulate the paths so we don't have to memorize or pass around
the path for each operation on the same data point. Scopes are a start but not sufficient.

A higher level model abstraction would encapsulate the path within and also provide the concepts of *Collection*, *Model* and
*Attributes* to build real data models that are more strongly typed - i.e. so that we know that a certain node is expected to
contain a certain kind of data and only allows certain kinds of operations acted upon it.

Each node should act as a *Resource* and only allow a subset of operations according to the type of Resource. The Resource should know where to act by using
its encapsulated path.

## Pipes and Resources

The *Racer* abstraction framework provided by this library provides two main entities that work together:

- Pipe
- Resource

A `Pipe` is an abstraction over a path with the concepts of parent and child pipes.

A pipe can have a single parent but multiple children. Pipes can be used to build a single path or complete graphs.
It is recommended to use pipes to reflect the entire underlying data model. Pipes are the main building blocks.

The underlying graph model is a *JSON* structure where each object is a *Document*. It is usually convenient that certain
Documents follow specific conventions and have a certain kind of *Schema* so that there is some control of what kind of data
can be expected at each data point.

This is where the concept of a *Model* gains importance. A Model acts as a kind of schema for a Document in the data model.
It defines the rules for how to operate on said document.

A model can be found in two different contexts.

- as a member of a Collection (CollectionModel)
- as an attribute of a Model (AttributeModel)

It is often the case that some nodes contain a list of multiple Documents of the same type.
These nodes are called collections. A Collection is an abstraction over such list nodes and ensures that there are certain
rules for the operations on the collection of models (Documents).

A Model can have one or more properties. Each property can be either:

- a Collection of models
- a Model
- an Attribute (simple values)

Each *Pipe* is connected to a *Resource* of the same type. The Resource is also connected back to the pipe.

Any Resource command always knows where in the graph it should apply the command.
It can either set its own path directly (if stand-alone), but more commonly it gets the path information from its pipe.

Depending on the type of Resource, only a subset of operations are available that makes sense for that kind of resource.
Attribute operations don't apply for a Collection, and Collection operations don't make sense for an attribute etc.

See also:

* [Readme](https://github.com/kristianmandrup/racer-mw/blob/master/README.md)
* [Pipe Design](https://github.com/kristianmandrup/racer-mw/blob/master/lib/pipe/Pipe-Design.md)
* [Resource Design](https://github.com/kristianmandrup/racer-mw/blob/master/lib/resource/Resource-Design.md)
* [Racer Sync Design](https://github.com/kristianmandrup/racer-mw/tree/master/lib/racer/Sync-Design.md)
* [Files overview](https://github.com/kristianmandrup/racer-mw/blob/master/lib/Files%20overview.md)

