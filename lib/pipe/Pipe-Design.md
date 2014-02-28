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

# what should really happen here?
.attribute(model: 'project')
# should turn into:
.attribute('project').model(_clazz: 'project')

# or allow model attribute
model(user, in: 'users').model(project).attribute('name').$set 'my proj'

# or allow model attribute
model(user, in: 'users').model(administers: project).attribute('name').$set 'my proj'

# what should really happen here?
.model(administers: project)
# should turn into:
.attribute('administers').model(project)

# users.1.projects.1.name = 'my proj'
model(user, in: 'users').attribute(projects: projects).model(project).attribute('name').$set 'my proj'

# what should really happen here?
.attribute(projects: projects)
# should be same as
.collection(projects: projects)

# the following is a bit problematic
.attribute(collection: projects)

# can only mean
.collection('projects')

# should be same as, however how can we determine the name 'projects' from the list?
.collection(projects: projects)
# only by assuming they all have the same _clazz and just use the first one.
# a fallback way, but not elegant or safe

# this is a much better way!
.collection(projects: projects)


# or allow collection (as attribute) on model
model(user, in: 'users').collection('projects').model(project).attribute('name').$set 'my proj'

# '_path.currentUser = user'
container('_path').model(current-user: user).$save!

# '_path.currentUser = user'
container('_path').attribute(current-user: user).$save!
```


## Pipes

```livescript
users-pipe = collection('users')

user-pipe = container('_page').model('user')

# each pipe build method returns the child pipe just added
# so we can continue building down the pipe naturally
# in order to return the root (starting pipe) we can end by executing the root! function
# which naturally returns the root of this pipe

page-pipe = container('_page').model('user').attribute(name: 'Kristian).root


# If we want to add several children to a pipe, we can use the plural form, such as attributes, and then open a scope
# where we can add each
page = container('_page').attributes ->
    @add('current').model 'user'
    @add('admin').model 'user'

# If we want to add a child of one type to a pipe, then another type, use the children

page = container('_page').children ->
         @attributes('name', 'age')

page = container('_page').children ->
         @attribute('name')
         @model('user')
```

### Validation

We could also build in some validation beyond the building rules sketched out above...

```
container('_page').allows.attributes(current-user: 'model', connected: 'boolean')
collection('projects').allows.model('project')

# implies that this collection is only for models with _clazz: 'project'
collection(clazz: 'project')

# what about subclasses?
collection('projects').allows.models('project', 'subproject')

# and how about?
.allows.any('project')
```

Can we somehow define all the types of a class in a smart way?

```
* animal:
  * 'mammal':
    * 'dog'
    * 'cat'
    * 'human'
  * 'fish'
  * 'bird'

It would have then have to turn it into...

* animal:
  * 'mammal':
    * 'dog'
    * 'cat'
    * 'human'
  * 'fish'
  * 'bird'
* 'mammal':
  * 'dog'
  * 'cat'
  * 'human'
* 'dog'
* 'cat'
* 'human'

# Then we can check!

.allows.any('animal')
.allows.any('mammal')
.allows.any('dog', 'cat')
```

What about simple types on attributes?

```
attribute('name').allows('string')

# or simply?
attribute('name', clazz:'string')

attribute(name: 'mike')

attribute('name', clazz:'string', value: 'anna')
```

Just some ideas... what do you think? suggestions are most welcome!

The above DSL might look rather "cumbersome", but the trade-off is a model that is much richer in functionality
and expressiveness. It describes the data model at a much deeper level... and is a building black for
powerful functionality!

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