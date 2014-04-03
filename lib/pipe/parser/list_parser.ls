requires = require '../../../requires'

Class       = require('jsclass/src/core').Class

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'

parser = ->
  requires.pipe!.parser!

BaseParser    = parser!.named 'base'
ObjectParser  = parser!.named 'object'

ListParser = new Class(BaseParser,
  initialize: (@parent-pipe, @value, options = {}) ->
    @call-super!

  parse: (list) ->
    lo.map list, ((item) -> @model item), @

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