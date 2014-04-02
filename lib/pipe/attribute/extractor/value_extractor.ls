Class       = require('jsclass/src/core').Class

lo = require 'lodash'
require 'sugar'

BaseValueExtractor = requires.pipe 'base/extractor/value_extractor'

AttributeValueExtractor = new Class(BaseValueExtractor,
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
    new AttributeValueExtractor @hash!

  hash: ->
    (@obj[0]): @obj[1]

)

module.exports = AttributeValueExtractor