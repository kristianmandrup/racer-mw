Class  = require('jsclass/src/core').Class
get    = require '../../../../requires' .get!
lo = require 'lodash'
require 'sugar'

BaseExtractor = get.base-extractor 'base'

ValueExtractor = new Class(BaseExtractor,
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

  # call again with normalized args
  hash-extractor: ->
    new ValueExtractor @hash
)

module.exports = BaseValueExtractor