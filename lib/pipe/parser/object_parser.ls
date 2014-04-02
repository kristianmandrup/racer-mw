requires = require '../../../requires'

Class       = require('jsclass/src/core').Class

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'

pipe = ->
  requires.pipe!.apipe

parser = ->
  requires.pipe!.parser!

BaseParser  = parser!.named 'base'
ListParser  = parser!.named 'list'
KeyParser   = parser!.named 'key'

PathPipe    = pipe 'path'

ObjectParser = new Class(BaseParser,
  initialize: (@parent-pipe, @value, options = {}) ->
    @call-super!
    @list-parser = new ListParser(@parent-pipe)
    @

  parse: (@obj) ->
    @key-parser.parse!

  key-parser: ->
    new KeyParser @obj
)

module.exports = ObjectParser