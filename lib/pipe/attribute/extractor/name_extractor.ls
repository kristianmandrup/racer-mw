Class       = require('jsclass/src/core').Class

requires    = require '../../../../requires'

AttributeBaseExtractor = requires.pipe 'attribute/extractor/base_extractor'

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