requires = require '../../../../requires'

Class       = require('jsclass/src/core').Class

util  = require 'util'
require 'sugar'

TupleBaseParser = requires.pipe 'parser/tuple/tuple_base_parser'

TupleListParser = new Class(TupleBaseParser,
  initialize: (@key, @value = []) ->
    @call-super!

  # collection or simple array
  plural: ->
    @can-build.any-of <[attributes collection no-list]>

  build: (name) ->
    @validate-array-value!
    @call-super!
)

module.exports = TupleListParser


