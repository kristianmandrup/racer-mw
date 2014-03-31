Class       = require('jsclass/src/core').Class

requires = require '../../../requires'

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

BaseExtractor = requires.pipe 'extractor/base_extractor'

ValueExtractor = new Class(BaseExtractor,
  initialize: (@obj) ->
    @

  value: ->
    @string-value or @obj-value!

  string-value: ->
    return {} if @is-string!

  obj-value: ->
    @inner-obj!
)

module.exports = ValueExtractor