# Validator helper

Contains the main Validation logic for validating pipes. It takes a *pipe* and a *list of valid types of pipes* as arguments.
It then validates if the pipe argument is a Pipe and one of the valid types (unless empty list).

- validate

It employs a Type Validator to perform the pipe *type validation*. In case the pipe is a list, it validates
if all pipes in the list are valid by the same validation rule.

## Type Validator

Performs pipe *type validation*. In case the pipe is a list, it validates
if all pipes in the list are valid by the same validation rule.

## Parent Validator

Performs Parent validation, used to validate if a Parent pipe which a Pipe is being attached to is a valid parent for that pipe.

- parent pipe must be a Container pipe
- attached pipe must be a valid Child pipe for that container
- parent must not already be in the family of the child (avoid circular reference)

Circular check: already an ancestor pipe or a child of the attached pipe



