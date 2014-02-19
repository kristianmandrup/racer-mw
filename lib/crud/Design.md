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

## Lessons learned

Operations fall into the following categories

**Operates on a Document within a collection**

```
users.1.user
users.2.user
```

**Operates on a Document within a collection of another document**

```
users.1.user.admins.1.admin-user
```

Should we validate as to whether this admin-user is valid for the user who owns the collection?

```
users.1.user.admins.1.admin-user.tags = ['abra', 'ca', 'dabra']
```

What if we move or pop an element from the tags collection (simple String values).
Should we validate with respect to the `admin-user`


**Operates on a simple attribute**

```
model.stringInsert 'users.1.user.text-area', 'hello'
```

Should authorize and validate on container Document `user`...

```
model.stringInsert '_page.text-area', 'hello'
```

No collection really. Should allow for this case too! can the text area in this case still have its own validation
In this case `_page` becomes the container ('page' model?).

## More advanced pipelining

From the above analysis we can see the following conclusions taking shape...

We need two middleware pipelines.

- container-stack
- item-stack

For some operations, it is the container model object that determines whether the operation is allowed
For others it is the item itself, being inserted into some named collection (not a model object).

The container-stack will always be simple, since it will never have to bother about marshalling or decoration.
It will thus only concern authorization and validation of the operation.
Most often it will likely be a "by-pass" operation... ;)

Example

Add new Document (model obj) to an attribute (List) of container Document (model obj).

The validation could take the container object, the attribute and the item obj and validate whether
the container obj allows this item obj to be inserted into the list.
This could be based either on the type of container and item object or even on the state of the container object (which
could be set up to live-update subscribe to changes in the model).

`mw-stack('container').validate container: container, attribute: attribute, item: item`

Of course this could later be optimized to a nicer DSL if need be

`mw-stack('container').validate-on(container).add-to(attribute, item)`

Please add more thoughts/ideas... :)
