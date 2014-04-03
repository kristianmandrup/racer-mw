requires = require '../../../requires'

Class       = require('jsclass/src/core').Class

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'

parser = ->
  requires.pipe!.parser!

BaseParser  = parser!.named 'base'
KeyParser   = parser!.named 'key'

PathPipe    = requires.pipe!.apipe 'path'

ObjectParser = new Class(BaseParser,
  initialize: (@parent-pipe, @value, options = {}) ->
    @call-super!
    @

  parse: (@obj) ->
    @key-parser.parse!

  key-parser: ->
    new KeyParser @obj
)

module.exports = ObjectParser