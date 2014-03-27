Class       = require('jsclass/src/core').Class

require 'sugar'

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

  primitive-types: [\String \Number]
)

module.exports = TupleValueTyper