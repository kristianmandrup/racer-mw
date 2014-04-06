Class  = require('jsclass/src/core').Class
get    = require '../../../../requires' .get!

BaseValueExtractor = get.base-extractor 'value'

lo = require 'lodash'
require 'sugar'

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