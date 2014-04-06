# Attribute Helpers

An Attribute pipe uses most of the `Base`, `Child` and `Named` pipe functionality "as is".

## Extractors:

The Attribute name extraction uses the `NamedPipe` extractor `NameExtractor`.
The ValueExtractor should simply check that it is a primitive value or list of primitives.
Functionality should already exist (somewhere in the code) that facilitates this.

Attribute value extractors should validate value (only primitives allowed).
Use ListValueExtractor and ValueExtractor.
