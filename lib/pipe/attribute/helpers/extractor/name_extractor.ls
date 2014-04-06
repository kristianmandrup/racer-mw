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

  # normalize array to hash
  hash: ->
    (@obj[0]): @obj[1]

  # call again with normalized args
  hash-extractor: ->
    new AttributeNameExtractor @hash
)

module.exports = AttributeNameExtractor 