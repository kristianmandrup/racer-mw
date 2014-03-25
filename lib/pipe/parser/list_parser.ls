requires = require '../../../requires'

Class       = require('jsclass/src/core').Class

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'

BaseParser    = requires.pipe 'parser/base_parser'
ObjectParser  = requires.pipe 'parser/object_parser'

ListParser = new Class(BaseParser,
  initialize: (@parser, @value, options = {}) ->
    @call-super!

  parse: (list) ->
    @debug-msg "parse-list #{util.inspect  list}"
    self = @
    list.map (item) ->
      return self.build 'model', value if self.inside-collection!
      self.parse-obj item

  inside-collection: ->
    @parent-type! is 'Collection'



  parse-obj: (obj) ->
    new ObjectParser(@parser).parse obj
)

module.exports = ListParser