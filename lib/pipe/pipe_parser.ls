/**
 * User: kmandrup
 * Date: 15/03/14
 * Time: 21:02

Parsing and building complex models

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
 */

requires = require '../../requires'

Class       = require('jsclass/src/core').Class

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'

# more granular design, easier reuse and better encapsulation of parser state at each point
PipeParser = new Class(

  initialize: (options = {}) ->
    @parent = options.parent
    @debug-on = options.debug
    @

  parse: (obj) ->
    @debug-msg "parse-obj #{util.inspect obj}"
    switch typeof! obj
    case 'Array'
      @parse-list obj
    case 'Object'
      @parse-object obj
    case 'String'
      @parse-str obj
    case 'Number'
      throw new Error "Can't parse number: #{obj}"
    default
      throw new Error "Can't parse this object: #{obj}, type: #{typeof! obj}"

  parse-list: (list) ->
    new ListParser(@).parse list

  parse-object: (obj) ->
    new ObjectParser(@).parse obj

  parse-str: (key) ->
    @parse-builder(value).build 'attribute', key

  parse-builder: (value) ->
    new PipeParseBuilder @, value
)

module.exports = PipeParser