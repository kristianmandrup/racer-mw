Module       = require('jsclass/src/core').Module

TupleValueTyper = new Class(
  initialize: (@value) ->

  any-of: -> (names) ->
    self = @
    names.flatten!.any (name) (-> self[name])

  unknown: ->
    typeof! @value is 'Undefined'

  model: ->
    typeof! @value is 'Object'

  attribute: ->
    typeof! @value in @primitive-types

  primitive-types:
    * \String
    * \Number
)

module.exports = TupleTypeDetector