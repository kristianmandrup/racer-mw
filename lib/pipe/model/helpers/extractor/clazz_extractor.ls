Class   = require('jsclass/src/core').Class
get     = require '../../../../../requires' .get!
lo      = require 'lodash'
util    = require 'util'
require 'sugar'

BaseExtractor = get.model-extractor 'base'

ClazzExtractor = new Class(BaseExtractor,
  initialize: (@obj) ->
    @call-super! if @call-super?
    @

  extract: ->
    @str-obj-clazz! or @obj-clazz! or @recurse-clazz! or @none!

  none: ->
    throw new Error "Model clazz could not be extracted from: #{util.inspect @obj}"

  recurse-clazz: ->
    new ClazzExtractor(@inner-obj!).extract! if @inner-obj!

  str-obj-clazz: ->
    @obj if @valid-string! and not nested

  obj-clazz: ->
    @obj._clazz if @valid-clazz!
)

module.exports = ClazzExtractor