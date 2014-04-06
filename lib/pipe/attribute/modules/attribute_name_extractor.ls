Module  = require('jsclass/src/core').Module
get     = require '../../../../requires' .get!

AttributeNameExtractor = new Module(
  initialize: (@obj) ->
    @validate-obj-clazz!
    @

  none:
    throw new Error "#{@info.type} pipe must be named by a String or Object (with _clazz), was: #{arg} [#{typeof arg}]"

  validate-obj-clazz: ->
    if typeof! @obj is 'Object' and not @obj._clazz
      throw new Error "Unable to extract #{@info.type} pipe properties from #{@obj} without class"
)

module.exports = AttributeBaseExtractor