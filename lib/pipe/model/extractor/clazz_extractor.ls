Class       = require('jsclass/src/core').Class

requires = require '../../../requires'

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

BaseExtractor = requires.pipe 'extractor/base_extractor'

ClazzExtractor = new Class(BaseExtractor,
  initialize: (@obj) ->
    @

  clazz: (obj, nested) ->
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