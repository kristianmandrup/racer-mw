Class       = require('jsclass/src/core').Class

require 'sugar'

ObjectUnpacker = new Class(
  initialize: (@obj) ->
    @validate-clazz!
    @

  unpack: ->
    [@key!, @value!]

  key: ->
    @_key = _.keys(@obj).first!

  value: ->
    @_value = _.values(@obj).first!

  validate-clazz: ->
    if @obj._clazz
      throw new Error "Unable to create Attribute from, #{util.inspect @obj} with class: #{@obj._clazz}"
)

module.exports = AttributeObjectUnpacker