Class  = require('jsclass/src/core').Class
get    = require '../../../../requires' .get!

AttributeBaseExtractor = get.attribute-extractor 'base'

lo = require 'lodash'
require 'sugar'

AttributeNameExtractor = new Class(AttributeBaseExtractor,
  initialize: (@obj) ->
    @

  string: ->
    @obj

  object: ->
    @first-key!

  first-key: ->
    @keys!.first!

  keys: ->
    _.keys @obj

  hash-extractor: ->
    new AttributeNameExtractor @hash

  hash: ->
    (@obj[0]): @obj[1]

)

module.exports = AttributeNameExtractor 