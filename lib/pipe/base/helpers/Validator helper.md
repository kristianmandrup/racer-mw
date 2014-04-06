# Validator helper

Contains the main Validation logic for validating pipes. It takes a *pipe* and a *list of valid types of pipes* as arguments.
It then validates if the pipe argument is a Pipe and one of the valid types (unless empty list).

- validate

It employs a Type Validator to perform the pipe *type validation*. In case the pipe is a list, it validates
if all pipes in the list are valid by the same validation rule.