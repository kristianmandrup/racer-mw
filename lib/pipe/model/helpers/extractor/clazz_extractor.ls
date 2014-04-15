Class   = require('jsclass/src/core').Class
get     = require '../../../../../requires' .get!
lo  = require 'lodash'
require 'sugar'

BaseExtractor = get.model-extractor 'base'

ClazzExtractor = new Class(BaseExtractor,
  initialize: (@obj) ->
    @

  extract: (obj, nested) ->
    @str-obj-clazz(nested) or @normalized-obj-clazz! or @recurse-clazz!

  recurse-clazz: ->
    @clazz @inner-obj!, true if @inner-obj!

  str-obj-clazz: (nested) ->
    @obj if @is-string and not nested

  normalized-obj-clazz: ->
    @normalized(@obj._clazz) if @valid-clazz!

  valid-clazz: ->
    typeof! obj._clazz is 'String'
)

module.exports = ClazzExtractor