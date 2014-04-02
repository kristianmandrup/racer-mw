Class       = require('jsclass/src/core').Class

lo = require 'lodash'
require 'sugar'

BaseExtractor = requires.pipe 'base/extractor/base_extractor'

BaseValueExtractor = new Class(BaseExtractor,
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

)

module.exports = BaseValueExtractor