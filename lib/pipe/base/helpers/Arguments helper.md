# Arguments helper

Helps to extract the arguments used when creating a Pipe. The main method is `extract` which does the following:

examines and throws an error if there are no arguments (empty). Otherwise validates the args and returns an array of
the first argument and remaining arguments if arguments are valid.

Is this really useful? Perhaps it would be better with an Arguments normalizer?

```
'x', 2
x: 2
```

Should imply the same thing... or perhaps we should not allow too many alternative ways of saying the same?




