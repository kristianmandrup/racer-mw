Class       = require('jsclass/src/core').Class

require 'lodash'

TupleValueTyper = new Class(
  initialize: (@value) ->

  any-of: -> (names) ->
    lo.find names.flatten!, ((name) -> @[name]), @

  unknown: ->
    typeof! @value is 'Undefined'

  model: ->
    typeof! @value is 'Object'

  attribute: ->
    typeof! @value in @primitive-types

  primitive-types: [\String \Number]
)

module.exports = TupleValueTyper