Class       = require('jsclass/src/core').Class

lo = require 'lodash'
require 'sugar'

AttributeBaseExtractor = new Class(
  initialize: (@obj) ->
    @validate-clazz!
    @

  extract: ->
    lo.find @obj-types! @is-obj-type, @

  obj-types: <[string object array none]>

  is-obj-type: (type) ->
    @[type] if @is-type type

  is-type: (type) ->
    typeof! @arg is type.capitalize!

  none:
    throw new Error "Attribute must be named by a String or Object (with _clazz), was: #{arg} [#{typeof arg}]"

  array: ->
    @extract-hash! if @is-two-array!

  extract-hash: ->
    @hash-extractor!.extract!

  is-two-array: ->
    @obj.length is 2

  validate-clazz: ->
    if typeof! @obj is 'Object' and @obj._clazz
      throw new Error "Unable to extract Attribute properties from #{util.inspect @obj} with class: #{@obj._clazz}"
)