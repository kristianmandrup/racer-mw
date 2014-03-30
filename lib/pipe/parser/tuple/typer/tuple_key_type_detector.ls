Class = require('jsclass/src/core').Class

lo = require 'lodash'

require 'sugar'

TupleKeyTypeDetector = new Class(
  initialize: (type) ->
    unless typeof! type is 'String'
      throw new TypeError "Type must be a String, was: #{type}"
    @type = type.capitalize!
    @

  find-tuple-type: ->
    @ttype-is ||= @_find-tuple-type! or 'none'

  _find-tuple-type: ->
    # matches-type is applied within current context for each iteration :)
    lo.find @key-types, @matches-type, @

  matches-type: (key-type) ->
    key-type.capitalize! is @type

  key-types: <[single plural path]>
)

module.exports = TupleKeyTypeDetector