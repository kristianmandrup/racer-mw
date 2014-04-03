Class       = require('jsclass/src/core').Class
lo  = require 'lodash'

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