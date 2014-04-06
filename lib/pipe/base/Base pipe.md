# Base Pipe

The `BasePipe` class is the base class for all Pipes and contains the most basic pipe functionality shared by all pipes.
Particular Pipe modules can override and inherit from this base functionality, so it can be used as a building black for further
specialization.

The /base folder is divided into /modules and /helpers. The modules can be included on any Pipe to add the functionality for
a particular functionality such as "resource access". The module exposes public functions added to the Pipe including that module.

The helpers are classed used by the modules. A helper encapsulates the more technical aspects of the functionality and in a way incapsulates
the "private" functions which should not be exposed on the pipe.