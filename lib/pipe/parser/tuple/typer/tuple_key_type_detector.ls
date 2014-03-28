Class = require('jsclass/src/core').Class
require 'sugar'

TupleKeyTypeDetector = new Class(
  initialize: (@type) ->
    @build-type-detectors!

  tuple-type-is: ->
    @ttype-is ||= @_tuple-type-is!

  _tuple-type-is: ->
    _.find @type-is, @key-types

  type-is: (key-type)->
    @["is#{key-type.capitalize!}"]! is @type

  build-type-detectors: ->
    # creates functions
    _.each @create-type-detector, @type-detectors!

  create-type-detector: (name) ->
    @[name] = (name) (-> @type is name.capitalize!)

  key-types: <[plural single path none]>
)

module.exports = TupleKeyTypeDetector