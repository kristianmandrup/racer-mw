# Pipe Design

Introduction and overview of Pipes.

## What are pipes?

Pipes are the main building blocks in this whole infrastructure. It is simply a more intelligent, more functional,
more data carrying information layer that abstracts your data layer into more logical OOP entities such as:

- Container (path)
- Collection
- Model
- Attribute

A Container is a top level entity such as `_session` or `_path`. It is simply an abstract placeholder to hold
 any sort of data (or pipe) underneath.

A Collection is a specific kind of Container which can hold one or more Documents, usually of the same kind.
In OOP speak, a Users collection would contain User objects, or subclasses of User, such as:
`GuestUser < User` and `AdminUser < User` (ruby class inheritance syntax).

A Model holds a `Document`, such as `User`. A `Model` can have one or more `Attributes`.
An `Attribute` is a simple value such as a `String` or `Integer` or can be a `Collection` or `Model`

Let's explore some different combinations from the above...

```livescript
# users.1.age = 7
collection('users').model(user).attribute('age').$set 7

# shorthand for above
model(user, 'users').attribute('age').$set 7

# users.1.project.name = 'my proj'
model(user, in: 'users').attribute(model: 'project').attribute('name').$set 'my proj'

# users.1.projects.1.name = 'my proj'
model(user, in: 'users').attribute(collection: 'projects').model(project).attribute('name').$set 'my proj'

# '_path.currentUser = user'
container('_path').model(current-user: user).$save!

# '_path.currentUser = user'
container('_path').attribute(current-user: user).$save!
```

The above DSL might look rather cumbersome, but the trade-off is a model that is much richer in functionality
and expressiveness. Simply more raw power!

```livescript
collection('users').models(users).$save!
models(users, in: 'users').$save!
```

Build pipe graphs

```livescript
container('_page').model(current-user: user).parent!.model(admin-user: user)

# or more elegantly
container('_page').attach (page) ->
  page.model(current-user: user)
  page.model(admin-user: user)

users = collection('users').attach (col) ->
  col.model(current-user)
  col.model(admin-user)

users.child('current-user').$get
```

A pipe has access to a Resource which is an abstraction on top of the Racer commands
such `model.get`, `model.set` and `model.push` etc.

In the above DSL examples, notice that when a $ is used on a pipe, it signifies a resource command.
Another way is as follows:

```livescript
users.child('current-user').$resource.get
```

The directs `$get` is simply a shorthand (forwards to `$resource.get`).

Let your imagination flow free.... Power of the mind :)