Class       = require('jsclass/src/core').Class

lo = require 'lodash'
require 'sugar'

AttributeValueExtractor = new Class(
  initialize: (@obj) ->
    @

  string: ->
    void

  object: ->
    @first-value!

  first-value: ->
    @values!.first!

  values: ->
    _.values @obj

  hash-extractor: ->
    new AttributeValueExtractor (@obj[0]): @obj[1]

)

module.exports = AttributeValueExtractor