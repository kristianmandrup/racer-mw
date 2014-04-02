Class       = require('jsclass/src/core').Class

requires    = require '../../../../requires'

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'

CollectionNameExtractor = new Class(
  initialize: (@arg) ->
    @

  plural: ->
    extract!.pluralize!

  singular: ->
    extract!.singularize!

  extract: ->
    @from-string! or @from-object! or @none!

  is: (type) ->
    typeof! @arg is type

  from-object: ->
    return unless @is 'Object'
    unless @arg._clazz
      throw new Error "Object passed must have a _clazz attribute, was: #{util.inspect @arg} [#{typeof @arg}]"
    @arg._clazz

  from-string: ->
    return unless @is 'String'
    @arg

  none: ->
    throw new Error "CollectionPipe constructor must take a String or Object as argument, was: #{@arg} [#{typeof @arg}]"
)

module.exports = CollectionNameExtractor