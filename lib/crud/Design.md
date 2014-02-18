# Design

## Read Doc

Query or Get documents, including using Filter. Apply only Authorization.

## Set Doc

Any operation which inserts or overwrites Documents into the model. The data must first be marshalled.

## Reposition Doc

Similar to Set, but since no new data is coming in, no need for marshalling step

## Create Doc

Any operation which specifically creates new data?

## Delete Doc

Any operation which deletes one or more Documents

## Read Attrib

Must indicate model (Doc) being read from, then authorize on that! Same for other Attrib ops

## Set Attrib

Any operation which inserts or overwrites non-Doc Attributes in the model.
The data must first be marshalled. How?

`marshaller-for('password').marshal password)`

## Set Array (non-docs)

Set Attrib should be called for each element in array? Not efficient
Better to marshal all first, then call single SetEach operation
Pipeline needs more thought for optimization of List data in general