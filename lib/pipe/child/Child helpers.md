# Child Pipe helpers

The Child Pipe helpers contain the following Helper classes particular to Child pipes:

- Name
- Navigator

## Name helper

Any Pipe has both a short local name and a full name. For a child pipe, the full name is constructed
 from concatenating the names of all its ancestor pipes in succession, thus giving it a unique name (or path) in the
 pipe graph. For a pipe that has no parent (not a child pipe), the local name and full name will be identical.

The name helper helps to calculate the full name for a Child pipe with ancestor pipes.

## Navigator helper

A Child pipe has ancestor pipes and can be given the ability to navigate up its ancestor pipes.
This can be used to retrieve an ancestor pipe, in order to perform some operation.

The navigator helper performs the heavy lifting.