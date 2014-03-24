# Parser Design

The parser is used to parse pure, raw data and turn it into a full data model, with Collections, Models and Attributes, using
some conventions.

## Collection

Named data entity in plural form, such as *users* with an Array of values, where each value is an Object.

## AttributeModel

Named data entity in singular form, such as *user* with a single value that is an Object.
Applies when the parent (container) is a Model or Path.

## CollectionModel

Single value (of an array) that is an Object when the parent (container) is a Collection.

## Attribute

Named data entity in any form, such as *name* where the value is a Primitive type, such as String or Number or Array.
For the Array case, each value must again be a primitive type (String, Number).

## Parser fallback rules

The above rules have certain limitations. Examples:

*Model anomaly*

Named data entity in plural form, such as *users* which is an Object. This should be parsed as a model.

*Collection anomaly*

Named data entity in singular form, such as *users* with an Array of values, where each value is an Object.

The parser should fall back to try these anomaly cases if the standard rules don't match the data.

## Data model value propagation

When the value for a pipe at any place in the model is changed, it needs to notify parent and/or child pipes of
 the change so that they can update their respective cached value.

To enable this functionality, a `FamilyNotifier` class is instantiated, and the pipe calls
`notify-children` and `notify-parent`.

The `notify-children` calls `on-parent-update` on each child whereas `notify-parent` calls `on-child-update` on the parent.
These calls will make the child or parent respectively set (update) their value according to the notification messenger and in turn
instantiate their own `FamilyNotifier` to propagate their changes further on in the data-model chain.

To avoid circularity, this algorithm will avoid notifying children when propagating up the ancestry chain and avoid notifying parents
when going down the child chain. This is achieved by having `on-parent-update` set `no-child: true` when the `FamilyNotifier`
for the next ancestry is created, which blocks notification to children. For `on-child-update` a `no-parent: true` is set to block
notification of parents.

Note that two hook methods are available on the pipe: `pre-notify-value` and `post-notify-value`.

For a pipe to update its value, it will call `raw-value` which calculates itself based on its own value and the values in its child tree.
