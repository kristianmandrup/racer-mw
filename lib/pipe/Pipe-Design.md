# Pipe Design

Introduction and overview of Pipes.

## What are pipes?

Pipes are the main building blocks. It is simply a more intelligent, more functional,
more data carrying information layer that abstracts your hierarchical JSON data model into logical OOP entities such as:

- Path
- Model
- Attribute
- Collection

### Path

A `Path` is a simple wrapper for a path in underlying data model. A Path pipe should only be
used when you want to avoid/disregard part of the data model for abstraction.
This would typically be when you are introducing this abstraction framework on an existing data model
 and want to introduce the abstraction layer step-by-step. Another reason could be that part of the data model
 is already abstracted (or taken care of) by some other logic or abstraction layer.

In any case, a Path pipe is just a thin wrapper over a path which allows you to pipe from that path and on.
A Path pipe can be "any data type" and can therefore have any of:

* `Attribute` (simple values)
* `Collection` (of models)
* `Model`

A Path pipe can be assigned a value, but since it is not a "real" data abstraction this is generally discouraged.

### Model

A Model is a wrapper for a `Document`. A model should have a class such as `User`.
A `Model` can have one or more attributes, which can be any of:

* `Attribute` (simple values)
* `Collection` (of models)
* `Model`

### Attribute

An `Attribute` is a wrapper for a simple value (or values), such as:

* `String` (text)
* `Number`
* `Date`

It can also contain a list of simple values using: `Array`

### Collection

A `Collection` contains of Models (Documents), usually of the same kind).
Typically, a `Users` collection would contain `User` objects.

## Piping

Piping is meant to be achieved efficiently via a method chaining API that this library provides.
Example:

`collection('users').model(user).attribute('age')`

Each pipe builder returns the pipe that was built in order that you can build on it.
This way it is efficient to build the whole pipe path to reflect the underlying data model.

### Path

The following is a typical example for when to use the `Path` pipe.
Piping the collection on to a specific point in the existing data model.
*Derby* already maintains the `_page` by its own, so we don't need to abstract it with a model.

```livescript
path('_page.current').collection('visitors').model(user)
```

### Model

```livescript
model('user')
```

The simplest way to build a Model pipe with data is to call the model constructor with an object
which contains a `_clazz` key with the name of the model (class) to be built to hold that data.

```livescript
user = {
  _clazz: 'user'
}

```livescript
model(user)
```

Builds:

```
 + user: {
     _clazz: 'user'
   }
```

We can however also override this default naming strategy and call the model node

```livescript
model(admin: user)
```

Builds:

```
 + admin: {
     _clazz: 'user'
   }
```

This strategy can also be used for the container object such as `_page` and `_session` if used in **Derby** or
some other Racer compatible framework with similar concepts.

```livescript
page = model(_page: page)
```

Builds:

```
 + _page: {
     _clazz: 'page'
   }
```

**Auto-wrapped models**

We can also make the model wrap itself inside a collection.

When model pipe is created, it will try to determine if it is meant to be created as a
 model at that level or to wrap itself as a member of a collection.

It will base this decision on the name it is given. If it is being named a singular, such as `user`,
it will jut create a normal model of that name. If it is named with a plural, such as `users`,
it will wrap itself in a collection of that name.

```livescript
model(users: user)
```

Builds:

```
 + users:
   [
     {
       _clazz: 'user'
     }
   ]
```

Note: This is a more efficient way to build a more complex pipe (no DSL chaining).

A model can contain named properties, where each property is one of:

* Attribute
* Model
* Collection

Adding a `hits` property that is an `Attribute`:

```livescript
page = model('_page')
page.attribute(hits: 'number')
```

Adding a `current-user` property which is a `Model`

```livescript
page.model(current-user: user)
```

Adding a `visitors` property which is a `Collection`

```livescript
page.collection('visitors')
```

Or using auto-wrap (via "plural form" detection)

```livescript
page.model(visitors: user)
```

### Attribute

An attribute is a named container for a simple value such as a `String` or `Number`
It must always be build on a `Model` pipe.

```livescript
page = model('_page')
page.attribute('hits')
```

Builds:

```
 + page:
     hits: undefined
```

The above example doesn't give us much benefit however.
Let's also provide a value. This is done by using key/value.

```livescript
model(user).attribute(<name>: <value>)
```

To extend our previous example:

```livescript
model(user).attribute(hits: 3)
```

Builds:

```
 + page:
     hits: 3
```

We can also provide *type* information by extending our constructor has with a `value` property:

```livescript
model(user).attribute(<name>: <type>, value: <value>)
```

For our example:

```livescript
page-hits = 1
page.attribute(hits: 'number', value: page-hits)
```

When we have assigned a type to the attribute, it will validate that only a value of that type can be set
for the attribute (and be *synced* with the data store - see *Resources*).

If we want to add multiple attributes to a model, it quickly seems a bit tedious this way:

```livescript
page.attribute(hits: 'number', value: 3)
page.attribute(status: 'string', value: 'ok')
```

A more efficient build API for adding multiple attributes is provided:

```livescript
page.attributes
  .add(hits: 'number', value: 3)
  .add(status: 'string', value: 'ok')
```

### Collection

To build a `Users` collection with one `User`:

```livescript
collection('users').model(user)
```

Builds:

```
 + users: [
    {}
   ]
```

As described under **Model** we can also have a model auto-wrap itself with a collection, achieving the same:

```livescript
model(users: user)
```

To efficiently add multiple users, we can employ the `models` builder, which provides the API as used for Attribute,
except here for adding multiple `Model` pipes:

```livescript
collection('users').models
  .add(kris)
  .add(emily)
```

We can even pass multiple users to add

```livescript
collection('users').models
  .add(kris, emily, adam, ...)
```

or pass the users as an Array:

```livescript
user-list = [kris, ...]
collection('users').models
  .add(user-list)
```

## Pipe navigation

Each pipe builder returns the pipe just built so that we can easily build the full pipe path via chaining.
A pipe can be "attached" to one parent. A pipe can have one or more children (unless it's an attribute pipe).

You can get the *parent* pipe of a pipe using the `parent` property. Naturally `children` contains all the children
 of the pipe:

```livescript
kris = collection('users').model(kris)
users = kris.parent
kris = users.children[0]
```

A `get` method is provided for a smoother API:

`kris = users.get 0` or `kris = users.first()` and `kris = users.last()`

To get a child attribute from a model:

```livescript
user = model(user)
name = user.child 'name'
```

A `get` method is provided for a smoother API in this case:

`name = user.get 'name'`

You can nvaigate multiple levels up a pipe using prev(levels):

```livescript
user = model('_page').model(users: user)
name = user.get 'name'
users = name.prev 2
```

If you are further down a long pipe, you can use `root` to get the root pipe.

```livescript
user = model('_page').model(users: user)
name = user.get 'name'
page = name.root()
```

## Advanced piping

Pipes become even more powerful when they are reused across a more complex data model.
You can detach, clone and attach the same pipe in multiple places. This way, if you have multiple
parts of the data model that share similar properties, it is easy to leverage this fact.

```livescript
user = model('_page').model(users: user)
name = user.get 'name'
user = name.prev()

current-user = model('_session').model(current-user: user)
```

We can also leverage the efficient "multi-builder" API.
Each `add` returns the collection of attributes that have so far been added.

```livescript
page-attributes = page.attributes
  .add(hits: 'number', value: 3)
  .add(status: 'string', value: 'ok')

session.attributes
  .add(page-attributes)
  .add(current-user: user)
```

Here we introduce another powerful shortcut, adding a model property current user via an attribute.
The attribute builder method will here detect that the value being set is an object, and try to build a model
 from this instead. The same can be done for a collection.

`.add(users: [kris, emily])`

This will build and attach (add) a collection property `users` with those models wrapped inside.

## Parsing and building complex models

In order to simplify building up a complex model, it would be convenient if we could simply parse
a model and make basic assumptions for how to build it using Collection-, Model- and AttributePipes.

Imagine we have a model like this:

```
_path:
  users:
    *
      name: 'Kris'
      email: 'kris@gmail.com'
    *
      name: 'Amy'
      email: 'amy@gmail.com'
  projects:
    *
      name: 'my project'
      user: '_path.users.1'
    *
      name: 'your project'
      user: '_path.users.2'
```

The parser should understand that the top most node `_path` since it has an underscore, is a `PathPipe`.
Then it should understand that users and projects are both collections, since they have plural names,
and each has an array of objects.

`path-pipe('_path').collections.add(users: users).add(projects: projects)`

Internally, as each user or project is added, it should create an attribute pipe for each own property key that does
not start with a special character such as `_` or `$`.

`collection('users').models().add(name: 'Kris', email: 'kris@gmail.com')`

Which would internally handle each model something like:

`.model(name: 'Kris', email: 'kris@gmail.com')`

It should internally add attributes like so, where 'user' is an (optional) "class" indicator.

`.model('user').attributes().add(name: 'Kris', email: 'kris@gmail.com')`

Could even allow without class, if collection is "class-less"

`.model().attributes()`

Calling `collection.model(...)` should always ensure that the model gets an appropriate id according to its position in the parent collection.

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

### Validation

Further down the line, as this framework develops, it might be nice to extend the data validation
from attribute types to also include Model class validation.

Any Pipe can implement a `validate-attch(parent)` method which will be called by `pre-attach-to` of `BasePipe` behind the scenes.
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
more clever design...

## Value object

The *Value object* should be its own entity which carries the validation logic.
The transferring the *Value object* would also transfer its validation logic. Much better!

The following could be a good, simple design:

```livescript
ValueObject = new Class(
  initialize: (@value) ->
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

This leads us to conclude, that it is easiest to determine an appropriate validator from the pipe info.
For a stand-alone resource we would have to take the last part of the path as the name.

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

## Pipes and Resources

This section contains a brief overview on how Pipes relate to Resources.
Pipes are mostly "intelligent" wrappers for the Path part of the Racer model API.
A pipe has access to its resource through the special `$resource` property

```livescript
user-resource = user-pipe.$resource

# apply some commands on the resource
```

The pipes pass any value assigned to its resource. The Resource is responsible for syncing the value
 with the Racer data layer (and underlying data store).

The Resource has access to its Pipe container via the `$pipe` property.

```livescript
user-pipe = user-resource.$pipe
```

The Resource uses its pipe internally in order to know where in the Racer model to sync the data.
The pipe is the "path part" of the resource.

The Resource can execute all of the Racer commands that apply for the kind of value it holds (collection, model or attribute).
A Resource can be any of:

- Collection
- Model
- Attribute

Each Resource inherits from `BaseResource` which contains common functionality shared by any resource.

Each type of Resource can only execute a subset of commands, those commands that are valid for the kind
 of value that it is responsible for syncing with *Racer*.

An `Attribute` resource can't execute a collection specific command on its attribute and vice versa.
From this it follows that a pipe can only execute the commands exposed by its resource.

All resources have a `$save` command which simply saves (sets) the current value of the resource to
 the path location defined by the pipe.

`user-pipe.$resource.$save()`

A shorthand `$res` is also available: `user-pipe.$res.$save()`

A shorthand of the `$resource` API is provided as a convenience. You can simply use `$<command>` directly on a pipe.

`user-pipe.$save()`

Setting the user model value to another user is a valid model command.

```livescript
user-pipe.$set emily
```

Inserting a string on a collection is invalid however (and made impossible).

```livescript
users-pipe.$resource.string-insert ...
```

For more details on how to use Resources and some of the internal Resource machinery, see the Resource doc.
