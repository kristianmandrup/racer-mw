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
      user: _path.users.1
    *
      name: 'your project'
      user: _path.users.2
```

The parser will determine that the top most node `_path` since it has an underscore, is a `PathPipe`.
Then it will parse users and projects as collections, since they have plural names,
and each has an array of objects.

`path-pipe('_path').collections.add(users: users).add(projects: projects)`

Internally, as each user or project is added, it will create a model pipe for each own property key that does
not start with a special character such as `_` or `$`.

`collection('users').models().add(name: 'Kris', email: 'kris@gmail.com')`

Which would internally handle each model something like:

`.model(name: 'Kris', email: 'kris@gmail.com')`

It should internally add attributes pretty much like so, where 'user' is an (optional) "class" indicator.

`.model('user').attributes().add(name: 'Kris', email: 'kris@gmail.com')`


Calling `collection.model(...)` will always ensure that the model gets an appropriate id according to its position in the parent collection.
