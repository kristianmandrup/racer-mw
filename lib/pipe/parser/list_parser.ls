requires = require '../../../requires'

Class       = require('jsclass/src/core').Class

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'

BaseParser    = requires.pipe 'parser/base_parser'
ObjectParser  = requires.pipe 'parser/object_parser'

ListParser = new Class(BaseParser,
  initialize: (@parser) ->
    @call-super!

  parse: (list) ->
    @debug-msg "parse-list #{util.inspect  list}"
    self = @
    list.map (item) ->
      return self.build 'model', value if self.inside-collection!
      self.parse-obj item

  inside-collection: ->
    @parent-type! is 'Collection'

  # collection or simple array
  parse-plural: (key, value) ->
    type = @list-type(key, value)
    return @parse-array key, value if type is 'array'
    return @parse-collection key, value if type in ['collection', 'empty']
    throw new Error "Unable to determine if plural: #{key} is a collection or array, was: #{type}"

  parse-collection: (key, value = []) ->
    unless _.is-type 'Array', value
      throw new Error "value must be an Array, was: #{typeof! value} #{util.inspect value}"
    @build 'collection', value, key

  parse-array: (key, value) ->
    unless _.is-type 'Array', value
      throw new Error "value must be an Array, was: #{typeof! value} #{util.inspect value}"
    @build 'attribute', value, key

  parse-obj: (obj) ->
    new ObjectParser(@parser).parse obj
)

module.exports = ListParser