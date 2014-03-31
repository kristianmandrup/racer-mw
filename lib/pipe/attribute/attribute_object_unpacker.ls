Class       = require('jsclass/src/core').Class

lo = require 'lodash'
require 'sugar'

AttributeObjectUnpacker = new Class(
  initialize: (@arg) ->

  unpack: ->
    lo.find @obj-types! @is-obj-type, @

  obj-types: <[string object array none]>

  is-obj-type: (type) ->
    @[type] if @is-type type

  is-type: (type) ->
    typeof! @arg is type.capitalize!

  string: ->
    [@arg, void]

  object: ->
    @unpack-obj @arg

  array: ->
    @unpack-obj @obj-hash! if @valid-array!

  obj-hash: ->
    (@arg[0]): @arg[1]

  none:
    throw new Error "Attribute must be named by a String or Object (with _clazz), was: #{arg} [#{typeof arg}]"

  valid-array: ->
    @arg.length = 2

  unpack-obj: (obj) ->
    @object-unpacker(obj).unpack!

  object-unpacker: (obj) ->
    new ObjectUnpacker obj
)

module.exports = AttributeObjectUnpacker