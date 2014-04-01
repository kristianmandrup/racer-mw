## Pipe Validation

Further down the line, as this framework develops, it might be nice to extend the data validation
from attribute types to also include Model class validation.

Any Pipe can implement a `validate-attach(parent)` method which will be called by `pre-attach-to` of `BasePipe` behind the scenes.
Here you can inject your customized validation logic for which pipes (with what values) are valid when attached to a given parent pipe.

This can f.ex be used by a *Collection* to limit the types of "classes" it will allow to be contained.
It could also be used by a *Model* to validate certain attribute values, or even to validate certain "named models",
such that:

```
user = {
  boss: boss-user
  secretary: secretary-user
}
```

Would validate a `boss-user` differently than the `secretary-user`, since they are assigned to different "model attributes".

You can also setup a a Pipe, to validate any value that is set on it. The `BasePipe` has a `set-value(value)` method which will call
`validate-value(value)` just before setting the value. You can implement `validate-value` to perform some validation.
The validation should return `false` (or throw an `Error` ?) if the value is invalid. By default `validate-value` will
 return true for any value.

We need a way to efficiently declare these validations outside and have an easy way to inject such validation methods
on the Pipes (or Resources?) that need them.

We have a `post-build` method on each pipe, which can be configured (customized) to call an external "service" which
looks up a validator for the given pipe (fx by type and name) and then injects an appropriate validation method.
It could also inject a `validator` on the pipe which `validate-value` will use to validate if present.

Obviously, having the same validation logic on both Pipe and Resource doesn't make any sense.
If a Pipe or Resource can be stand-alone with a value, and the value can be transferred between them we need a
more clever design... (see below). We need to encapsulate the value in a *ValueObject* that can have its own validation
logic assigned to guard the update of its value!

## Advanced class based validation

The following idea is left as an exercise...

```livescript
collection('projects').allows 'project'
```

Implies that the collection projects only allows models project models,
i.e. model objects with: `_clazz: 'project'`

A collection might allow several similar classes (f.ex sub classes):

```livescript
collection('projects').allows 'project', 'sub-project'
```

Would be more powerful if we could just specify:

```livescript
collection('projects').allows any: 'project'
```

And through previous declarations, the framwork would know which classes are of the kind "project"

```livescript
* animal:
  * 'mammal':
    * 'dog'
    * 'cat'
    * 'human'
  * 'fish'
  * 'bird'
```

It would have then have to turn it into...

```livescript
* animal:
  * 'mammal'
  * 'dog'
  * 'cat'
  * 'fish'
  * 'bird'
* mammal:
  * 'dog'
  * 'cat'
  * 'human'
* 'dog'
* 'cat'
* 'human'
* 'fish'
* 'bird'
```

Then we can check!

```livescript
.allows.any('animal')
.allows.any('mammal')
.allows.any('mammal', 'fish')
```