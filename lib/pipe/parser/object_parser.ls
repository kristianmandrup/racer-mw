requires = require '../../../requires'

Class       = require('jsclass/src/core').Class

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'

BaseParser  = requires.pipe 'parser/base_parser'
ListParser  = requires.pipe 'parser/list_parser'
KeyParser   = requires.pipe 'parser/key_parser'
PathPipe    = requires.apipe 'path'

ObjectParser = new Class(BaseParser,
  initialize: (@parent-pipe, @value, options = {}) ->
    @call-super!
    @list-parser = new ListParser(@parent-pipe)
    @

  parse: (@obj) ->
    @debug-msg "parse-object #{util.inspect obj}"
    parse-keys!

    parse-keys: ->
      @key-parser.parse!

    key-parser: ->
      new KeyParser @obj
)

module.exports = ObjectParser