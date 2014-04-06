# Base pipe modules

The following ase pipe modules add specific functionality to any Base pipe.

- CleanSlate
- Describer
- Resource
- Setter
- Validation
- Value

## CleanSlate

Decorates with placeholder methods and properties for any Pipe to make for a "Clean Slate" which other modules can override to provide the
 "real" functionality.

*methods* : return void or throw an Error.
*properties* : are void, an empty array or throw an Error.

## Describer

Decorates with a `describe` function which describes the basic properties of the pipe, such as its name, type, value etc.

- describe

Particular pipes, such as Model pipes can override this describe to f.ex add a `clazz` property or a Container pipe can
add a Children descriptor.

## Resource

Decorates with a `set-res` method, which sets the `$res` property to a new `Resource` instance that matches the type of Pipe.
Thus an `AttributePipe` will be "matched up" with an `AttributeResource` which contains appropriate
data store functionality to operate on simple attributes in the underlying data model.

## Setter

Decorates with basic `set*` methods such as `setAll`, to set the basic properties of the Pipe, such as name and value.
Particular pipes can override these set methods for more advanced functionality, such as setting the full name for Child pipes
or setting the `clazz` for Model pipes.

- setAll
- setName
- setValue

## Validation

Decorates with basic pipe validation methods such as `isPipe`, which determines if an argument is a Pipe or not.
The validation module uses a Validator helper to perform the validation.

- isPipe

The base helpers include other Validator helpers such as Parent validator and Type validator.
Perhaps some of the core functions from these Validator helpers should also be made available in the validation module.

## Value

Decorates with basic value functionality. A value is always encapsulated in a Value Object.

- createValueObj : create new "bare" Value Object
- value : get value from Value Object
- setValue(value, options) : set value of Value Object
- updateValueHelper - helper which manages updating the Value Object

