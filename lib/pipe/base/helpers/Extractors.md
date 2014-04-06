# Extractors

The Extractor helpers are meant as utilities to help extract specific core properties form the arguments, to be used by
the Setter module, to set name, value etc.

## Base extractor

Normalizes an array of two values into a key-value hash (tuple).
3 or more arguments throws an error.

We should instead assume that the first argument is the name and the rest makes up an array which is the value.
But this only applies for a `Collection` or `Attribute` pipe. But we need a shared place to keep this functionality.
Perhaps we can check if the pipe in question allows an array value and if so, normalize the array value ;)

We should also only extract the name if it is a named pipe, otherwise treat all the args as part of the Value.

This conditional extractor functionality should be placed in `NamedPipe` and `Unnamed` pipe respectively.