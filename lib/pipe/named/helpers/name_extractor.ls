Class   = require('jsclass/src/core').Class
get     = require '../../../../requires' .get!
lo      = require 'lodash'
require 'sugar'

BaseExtractor = get.base-extractor 'base'

NameExtractor = new Class(BaseExtractor,
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

  # call again with normalized args
  hash-extractor: ->
    new NameExtractor @hash
)

module.exports = BaseNameExtractor