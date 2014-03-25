requires = require '../../../../requires'

Class       = require('jsclass/src/core').Class

util  = require 'util'
require 'sugar'

TupleBaseParser = requires.pipe 'parser/tuple/tuple_base_parser'

TupleListParser = new Class(TupleBaseParser,
  initialize: (@key, @value) ->
    @call-super!

  # collection or simple array
  parse-plural: ->
    @array! or @collection! or @none!

  collection: ->
    return unless @is-collection!
    @value ||= []
    build 'collection'

  array: ->
    return unless @is-array!
    @build 'attribute'

  none: ->
    throw new Error "Unable to determine if plural: #{@key} is a collection or array, was: #{@list-type!}"

  is-array: ->
    @list-type! is 'array'

  is-collection: ->
    @list-type! in @collection-types

  collection-types: ['collection', 'empty']

  build: (name) ->
    @validate-array!; @call-super!
)

module.exports = TupleListParser


