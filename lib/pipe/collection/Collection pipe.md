# Collection pipe

A `Collection` pipe is a Container pipe which can contain one or more Anonymous Model pipes as children.
The only Anonymous Model pipe is the `CollectionModel` pipe.

## Attacher

The Attachers take care of attaching and detaching `CollectionModel` pipes orderly.

## Builder

The Builders are used to dynamically build and attach `CollectionModel` pipes to the pipe.

## Extractor

The extractors come in the form of:

- NameExtractor
- ValueExtractor

The NameExtractor is used to extract the name of the collection. It will be pluralized (by convention).
The ValueExtractor is used to extract the value and then build and attach child `CollectionModel` pipes accordingly.

## Setter

The Setters are used to set `name` and `value` of the Collection pipe.

## Value

The Value modules are used to set the value of the Collection pipe, using the `ArrayValueObject to encapsulate the array.