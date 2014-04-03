# Model Design

A Model pipe is a pipes which contains a value in the form of an Object, ie. key-values

A Model comes in two flavors:

- AttributeModel
- CollectionModel

## AttributeModel

The `AttributeModel` is a "Named pipe". An `AttributeModel` is a model which acts as an attribute
on another pipe that can take Named pipes as children.

## CollectionModel

The `CollectionModel` is an anonymous Model pipe. It contains an Object which is part of an array of values, contained by
the particular Container pipe: `Collection`. A `CollectionModel` has no name, and its id is simply its position in the
array of its parent pipe, ie. its position within the Collection pipe value array.
This position (index) starts goes from 0 just as a normal index in an array.

## Modules

The Collection uses the following helper modules:

- Value
- Setter

The `Setter` module is used to retrieve the `name` (and `id`), `value` and `clazz` to be set on the Model.
The `Value` module is used to handle the setting of the `value`, which includes notifying child or parent models and
 calculating the raw value from its own and child values.

## Helpers

- Extractor
- Builder

### Builder

The builders come in two flavors

- ModelBuilder
- ModelsBuilder

The `ModelBuilder` is used to build and attach a single model to the model as an `AttributeModel`.
The `ModelsBuilder` is used to build and attach multiple models to the model as a set of `AttributeModels`.

