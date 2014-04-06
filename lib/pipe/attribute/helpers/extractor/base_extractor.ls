Class  = require('jsclass/src/core').Class
get    = require '../../../../requires' .get!

BaseExtractor = get.base-extractor 'base'

lo    = require 'lodash'
require 'sugar'

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