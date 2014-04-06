# Attribute Design

An `Attribute` pipe is a simple `NamedPipe`that is a `ChildPipe` which cannot have any children.
An Attribute pipe be a child of and `ContainerPipe` which accepts `NamedPipe` children, such as:

 - CollectionModel
 - AttributeModel

The `ListAttributePipe` is a specific kind of AttributePipe which is used for attributes that expect a list (Array) value.
The value extract and value setting (and ValueObject) will then be specialized to handle array values.


