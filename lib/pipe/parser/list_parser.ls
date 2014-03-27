requires = require '../../../requires'

Class       = require('jsclass/src/core').Class

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'

BaseParser    = requires.pipe 'parser/base_parser'
ObjectParser  = requires.pipe 'parser/object_parser'

ListParser = new Class(BaseParser,
  initialize: (@parent-pipe, @value, options = {}) ->
    @call-super!

  parse: (list) ->
    @debug-msg "parse-list #{util.inspect  list}"
    self = @
    list.map (item) ->
      self.model item

  model: (item) ->
    @collection-model or @parse-obj item

  attribute-model: (item) ->
    @parse-obj item

  collection-model: ->
    @build 'model', @value if @inside-collection!

  inside-collection: ->
    @parent-type! is 'Collection'

  parse-obj: (obj) ->
    new ObjectParser(@parent-pipe).parse obj
)

module.exports = ListParser