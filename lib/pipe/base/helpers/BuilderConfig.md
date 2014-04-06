# BuilderConfig

This BuilderConfig helper has the responsibility of adding builder methods to a pipe.
It is passed a name of a pipe type (and builder function to add) and a list of valid types (of pipes) to be allowed.
It will validate if the name is in the valid types and then proceed to add the builder method.

It needs some major refactoring. It should only receive the name of the function to build for.
The validation should take place outside. It should also receive the pipe for which to add the methods or better build an internal
an object with the builder methods, which the pipe can then use to decorate itself (from the outside).

*REFACTOR* !!