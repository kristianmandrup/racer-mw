Class       = require('jsclass/src/core').Class

requires = require '../../../requires'

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

BaseExtractor = new Class(
  initialize: (@obj) ->
    @

  inner-obj: ->
    @inner ||= @obj[@name-from-object!]

  normalized: (val) ->
    return void if lo.is-empty val
    val

  is-string: ->
    typeof! obj is 'String'

  is-object: ->
    typeof! obj is 'Object'
)

module.exports = BaseExtractor