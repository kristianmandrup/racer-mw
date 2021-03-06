# Files overview

**Important: Deprecated! Needs rewrite to sync with existing structure!!**

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

### PathResource

Used to create a container object which is not a collection and not a model either, such as `_page`.


### CollectionResource

Can maintain a list of ModelResource objects (through its pipe).


### ModelResource

Can have *AttributeResource* resources (through its pipe).

### BaseResource

Contains base functionality for any *Resource*, such as access to the pipe and infrastructure services such as
the gateway (*RacerSync*)to Racer store execution.

### Filter and Query

*Filter* and *Query* are special objects, returned by filter and query functions from Racer. Each provide a subset of functions available
for further chaining, such as `get` and `ref` that act on the result.

*Queries* contain a set of scoped queries for reuse (much like *Rails* "named scopes").

### ResourceCommand

Wraps a command ready for execution on Racer via *RacerSync*.

### Crud

The `MwFactory` in the `crud` folder is used to create an input (and optionally output) middleware stack
for a given CRUD command. Only 'read' requires the output stack (decorator - decorate data read).

### Command

The `CommandBuilder` is used to dynamically build all the command functions on each type of Resource.
It uses the `ArgStore` (from `resource/arg` folder) which defines how a function for a given command is to be built.
There are four types of commands

- on
- set
- create
- "normal"

A *create* command creates a new object such as `Filter` or `Query`.
A *set* command sets an internal resource variable with the result of the command.
...

### Arg

Mappings of all the different commands, grouped by "type"

- array
- basic
- query
- reference
- scoped
- string

The `store.ls` file contains the `ArgStore` which assembles a full store of "command argument definitions".

The `validation` folder contains logic for validation and error handling of the arguments passed to
a given resource command.

## Racer

The `racer` folder contains code specifically targeted toward integration with Racer.
`RacerCommand` encapsulates a command being sent to Racer for execution.
It is a simple DSL wrapper and container for an action (command) and the hash or arguments.
`StoreConfig` contains a default Racer connector configuration.

`RacerSync` is the main class of interest. It performs the actual execution of a `RacerCommand` in the Racer engine,
 passing the arguments in the correct order for the command and employing any middleware.

 The middleware for any command is based on which kind *CRUD* action it is. Each mutate (*CUD*) action has an **input**
 middleware stack (layers to go through before the command (with data) is executed via Racer.
 Any command which is a kind of *Read* action first goes through an input stack and then the data read
 goes through an output stack to be decorated (enriched).


## Pipe

The main Pipes are the following:

- Path
- Collection
- Model (AttributeModel, CollectionModel)
- Attribute

A graph of pipes can be built to encapsulate the hierarchical model structure.
The pipe graph (similar to a DOM) makes up a more "intelligent" description of the model and carries much more information.

The pipes make up the main abstraction layer on top of the Racer model API.
Pipes can be *attached* and *detached* from any other pipe that allows it as a child pipe.

The `dsl.ls` file, contains the main DSL that is made available with this library (external API).

The PipeFactory is used to build a Pipe (might be deprecated?). The `PathResolver` is used to resolve the
full path of a pipe. Note: The path should be cached until the structure of the local pipe graph changes...

The `BasePipe` simply contains base functionality for any pipe.






