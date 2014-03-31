Class       = require('jsclass/src/core').Class

requires = require '../../../requires'

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

BaseExtractor = requires.pipe 'extractor/base_extractor'

NameExtractor = new Class(BaseExtractor,
  initialize: (@obj) ->
    @

  name: ->
    @name-from-clazz! or @normalized-name!

  normalized-name: ->
    @normalized @str-name! or @first-key!

  name-from-clazz: ->
    obj._clazz if @obj._clazz isnt void

  str-name: ->
    @obj if @is-string!

  first-key: ->
    _.keys(@obj).first!

)

module.exports = NameExtractor