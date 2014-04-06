Class   = require('jsclass/src/core').Class
get     = require '../../../../requires' .get!
lo      = require 'lodash'
require 'sugar'

BaseExtractor = get.base-extractor 'base'

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