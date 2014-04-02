Class       = require('jsclass/src/core').Class

lo = require 'lodash'
require 'sugar'

BaseExtractor = requires.pipe 'base/extractor/base_extractor'

AttributeBaseExtractor = new Class(BaseExtractor,
  initialize: (@obj) ->
    @validate-clazz!
    @

  none:
    throw new Error "Attribute must be named by a String or Object (with _clazz), was: #{arg} [#{typeof arg}]"

  validate-clazz: ->
    if typeof! @obj is 'Object' and @obj._clazz
      throw new Error "Unable to extract Attribute properties from #{util.inspect @obj} with class: #{@obj._clazz}"
)