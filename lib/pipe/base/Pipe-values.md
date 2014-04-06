## Value object

The *Value object* should be its own entity which carries the validation logic.
Then when transferring the *Value object* we also transfer its validation logic.

```livescript
ValueObject = new Class(
  initialize: (@container, @value) ->
    @valid = @validate @value

  valid: true

  validate: ->
    true
)
```

However how do we inject the correct validation logic per value, or according to the context of the value?
How do we know a value is an age and should be validated via the age validator?

From the resource: We have the resource type (fx model, attribute), the pipe unless the resource is stand-alone, otherwise we always have the path.
From the pipe: We have the pipe, pipe type and path. For an attribute we have the name of the attribute etc.

This leads us to conclude, that it is easiest to determine an appropriate validator from the pipe/resource info.
For a stand-alone resource we would have to take the last part of the path as the name.

## Marshalling a pipe value

If a model value is split into all its attribute pipes or sub-models, how do we ensure that that the resource has access
to the full value without all the wrapping? We need a way to unwrap a given node value.

```
console.log user-model-pipe.raw-value()

# =>
{
  name: 'Kris',
  email: 'kris@gmail.com',
  _clazz: 'user'
}
```

Also, whenever a child node (child pipe value) is updated, the values of each parent in the chain should also be updated using the `raw-value`.
This is achieved internally via a `on-child-update` notification system, where each parent is notified recursively.
