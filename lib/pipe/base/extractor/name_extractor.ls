Class       = require('jsclass/src/core').Class

requires    = require '../../../../requires'

BaseExtractor = requires.pipe 'base/extractor/base_extractor'

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