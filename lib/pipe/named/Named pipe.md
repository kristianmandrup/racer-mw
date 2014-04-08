# Named pipe

The named pipe is a decorator to be used by any pipe which has (and requires!) a name, such as:

- Collection
- AttributeModel
- Attribute

Any named pipe should:

- use a `NameExtractor` to extract the name from the arguments
- use a `ValueExtractor` to extract the value part of the arguments.
- have a `setName` method which sets `this.name` to the name extracted.

See *Named helpers* for details on these extractors.