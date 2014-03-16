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

CollectionPipe    = requires.apipe 'collection'
AttributePipe     = requires.apipe 'attribute'
ModelPipe         = requires.apipe 'model'
PathPipe          = requires.apipe 'path'

Class       = require('jsclass/src/core').Class

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'


# TODO: Needs major refactoring into sub-parser classes in order to facilitate testing,
# more granular design, easier reuse and better encapsulation of parser state at each point
Parser = new Class(
  initialize: (@obj) ->
    @

  parse: ->
    switch typeof! @obj
    case 'Array'
      @parse-list @obj
    case 'Object'
      @parse-obj @obj
    default
      throw new Error "Value being parsed must be an Object or Array, was: #{typeof! @obj}"

  parse-obj: (obj) ->
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

  parse-object: (obj) ->
    self = this
    keys = _.keys(obj)
    return [] if keys.length is 0
    mapped = keys.map (key) ->
      value = obj[key]
      self.parse-tupel key, value
    if mapped.length is 1 then mapped.first! else mapped

  parse-tupel: (key, value) ->
    parser = switch @tupel-type key
    case 'single' then 'parseSingle'
    case 'plural' then 'parsePlural'
    case 'path' then 'parsePath'
    @[parser] key, value

  tupel-type: (key) ->
    unless _.is-type 'String', key
      throw new Error "Key must be a String, was: #{typeof! key}, #{util.inspect key}"

    first-char = key[0]
    return 'path' if first-char is '_' or first-char is '$'

    return 'single' if key.singularize! is key
    return 'plural' if key.pluralize! is key
    throw new Error "Can't determine tupel type from key: #{key}"

  parse-single: (key, value) ->
    unless _.is-type 'String', key
      throw new Error "Key must be a String, was: #{typeof! key}, #{util.inspect key}"

    @debug-msg "ModelPipe: #{key}"
    new ModelPipe "#{key}": value

  parse-path: (key, value) ->
    @debug-msg "PathPipe: #{key}"
    path-pipe = new PathPipe key
    return path-pipe unless value

    unless _.is-type 'Object' value
      throw new Error "PathPipe can not be extended with #{value}, must be an Object, was: #{typeof! value}"

    pipe = @parse-obj value
    path-pipe.attach pipe
    path-pipe

  # collection or simple array
  parse-plural: (key, value) ->
    type = @list-type(key, value)
    switch type
    case 'collection'
      @parse-collection key, value
    case 'array'
      @parse-array key, value
    case 'empty'
      @parse-collection key, []
    default
      throw new Error "Unable to determine if plural: #{key} is a collection or array, was: #{type}"

  # test if value is list of Object or list of simple types
  # if mixed, throw error
  list-type: (key, value) ->
    return 'empty' if value is void

    unless _.is-type 'Array', value
      throw new Error "plural value #{key} must be an Array, was: #{typeof! value} #{util.inspect value}"

    return 'empty' if value.length is 0

    all-objects = value.every (item) ->
      _.is-type 'Object', item
    return 'collection' if all-objects

    all-simple = value.every (item) ->
      _.is-type('String', item) or _.is-type('Number', item)
    return 'array' if all-simple
    'mixed'

  parse-collection: (key, value) ->
    unless _.is-type 'Array', value
      throw new Error "value must be an Array, was: #{typeof! value} #{util.inspect value}"

    @debug-msg "CollectionPipe: #{key}"
    new CollectionPipe "#{key}": value

  parse-array: (key, value) ->
    unless _.is-type 'Array', value
      throw new Error "value must be an Array, was: #{typeof! value} #{util.inspect value}"

    @debug-msg "AttributePipe: #{key}"
    new AttributePipe "#{key}": value

  parse-str: (text) ->
    @debug-msg "AttributePipe: #{text}"
    new AttributePipe text

  parse-list: (list) ->
    self = @
    list.map (item) ->
      self.parse-obj item

  debug-on: false
  debug: ->
    @debug-on = true

  debug-msg: (msg) ->
    console.log msg if @debug-on
)

module.exports = Parser