Class       = require('jsclass/src/core').Class

lo = require 'lodash'
require 'sugar'

BaseExtractor = new Class(
  initialize: (@obj) ->
    @validate!
    @

  validate: ->
    true

  extract: ->
    lo.find @obj-types! @is-obj-type, @

  obj-types: <[string object array none]>

  is-obj-type: (type) ->
    @[type] if @is-type type

  is-type: (type) ->
    typeof! @arg is type.capitalize!

  none:
    throw new Error "Extraction error"

  array: ->
    @extract-hash! if @is-two-array!

  extract-hash: ->
    @hash-extractor!.extract!

  is-two-array: ->
    @obj.length is 2

  hash: ->
    (@obj[0]): @obj[1]
)

module.exports = BaseExtractor