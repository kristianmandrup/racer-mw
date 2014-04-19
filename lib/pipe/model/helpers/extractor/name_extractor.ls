Class   = require('jsclass/src/core').Class
get     = require '../../../../../requires' .get!
lo  = require 'lodash'
require 'sugar'

BaseExtractor = get.model-extractor 'base'

NameExtractor = new Class(BaseExtractor,
  initialize: (@obj) ->
    @call-super! if @call-super?
    @

  extract: ->
    @name-from-clazz! or @normalized-name! or @none!

  none: ->
    throw new Error "Model name could not be extracted from: #{@obj}"

  normalized-name: ->
    @normalized @str-name! or @key-name!

  key-name: ->
    @first-key! unless @first-key! is '_clazz'

  name-from-clazz: ->
    @obj._clazz if @valid-clazz!

  str-name: ->
    @obj if @valid-string!
)

module.exports = NameExtractor