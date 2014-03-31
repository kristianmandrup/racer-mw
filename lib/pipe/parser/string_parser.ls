requires = require '../../../requires'

Class       = require('jsclass/src/core').Class

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'

BaseParser  = requires.pipe 'parser/base_parser'

StringParser = new Class(BaseParser,
  initialize: (@parser)->
    @

  parse: ->
    @parse-builder(value).build 'attribute', key

  parse-builder: (value) ->
    new BaseParser @, value
)

