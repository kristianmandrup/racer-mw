Class  = require('jsclass/src/core').Class
get    = require '../../../../requires' .get!

BaseExtractor = get.base-extractor 'base'

lo = require 'lodash'
require 'sugar'

BaseNameExtractor = new Class(BaseExtractor,
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

)

module.exports = BaseNameExtractor