Class   = require('jsclass/src/core').Class
get     = require '../../../requires' .get!
lo  = require 'lodash'
require 'sugar'

BaseExtractor = get.base-extractor 'base'

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