## Piping

Piping is meant to be achieved efficiently via a method chaining API that this library provides.
Example:

`collection('users').model(user).attribute('age')`

Each pipe builder returns the pipe that was built in order that you can build on it.
This way it is efficient to build the whole pipe path to reflect the underlying data model.

This is the underlying chaining API for building up a model. There are various shortcuts such as parse,
 which can parse an object and build a model accordingly using specific rules.

However for full control of the build process, you will need to use this underlying API.
Often a mix is useful, where you build large parts of the model simply by parsing a blue-print model
and then fine-tune specific parts that the parser can't determine on its own.

### Path

The following is a typical example for when to use the `Path` pipe.
Piping the collection on to a specific point in the existing data model.
*Derby* already maintains the `_page` by its own, so we don't need to abstract it with a model.

```livescript
path('_page.current').collection('visitors').model(user)
```

### Model

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

We can however also override this default naming strategy:

```livescript
model(admin: user)
```

Builds:

```
 + admin: {
     _clazz: 'user'
   }
```

**Auto-wrapped models**

The model can also be added to a collection.

When model pipe is created, it will try to determine if it is meant to be created as a
 model at that level or to be used as a member of a collection.

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

Note: This is a more efficient way to build a more complex pipe.

A model can contain named properties, where each property is one of:

* Attribute
* Model
* Collection

Adding a `hits` property that is an `Attribute`:

```livescript
page = model('_page')
page.attribute(hits: 'number')
```

Adding a `current-user` property which is an `AttributeModel`

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

```livescript
hits   = {hits: 'number', value: 3}
status = {status: 'string', value: 'ok'}

page.attributes.parse [hits, status]
```

And even shorter :)

```livescript
page.parse-attrs [hits, status]
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

Using the shortcut `parse` method to achieve the same

```livescript
collection('users').parse kris, emily, adam
```

And even shorter :)

```livescript
parse users: [kris, emily, adam]
```

And even...

```livescript
page.parse-cols users, projects
```

## Advanced piping

Pipes become even more powerful when they are reused across a more complex data model.
You can detach, clone and attach the same pipe in multiple places. This way, if you have multiple
parts of the data model that share similar properties, it is easy to leverage this fact.

```livescript
user = path('_page').model(users: user)
name = user.get 'name'
user = name.prev()

current-user = path('_session').model(current-user: user)
```

We can also leverage the efficient "multi-builder" API.
Each `add` returns the collection of attributes that have so far been added.

```livescript
page-attributes = page.attributes
  .add(hits: 'number', value: 3)
  .add(status: 'string', value: 'ok')
```
