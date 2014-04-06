## Pipe navigation

Each pipe builder returns the pipe just built so that we can easily build the full pipe path via chaining.
A pipe can be "attached" to one parent. A pipe can have one or more children (unless it's an attribute pipe).

The `PipeNavigator` is a helper class that can be found in the `pipe/base` folder.
You can override it (if need be) for specific pipes.

You can get the *parent* pipe of a pipe using the `parent` property. Naturally `children` contains all the children
 of the pipe:

```livescript
kris = collection('users').model(kris)
users = kris.parent
kris = users.child-list[0]
```

A `get` method is also provided:

`kris = users.get 1` or `kris = users.first()` and `kris = users.last()`

To get a child attribute from a model:

```livescript
user = model(user)
name = user.child 'name'
```

You can also use either of the dsl methods: `col`, `modl` and `attr` as wrappers of child.
`name = user.attr 'name'` to get the attribute pipe 'name' of user.

The `get` method can also be used: `name = user.get 'name'`

You can navigate multiple levels up a pipe using prev(levels):

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
