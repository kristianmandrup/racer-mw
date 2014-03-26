requires = require '../../../../requires'

Class       = require('jsclass/src/core').Class

util  = require 'util'
require 'sugar'

TupleBaseParser = requires.pipe 'parser/tuple/tuple_base_parser'

TupleObjectParser = new Class(TupleParser,
  initialize: (@key, @value) ->
    @validate-string-key!; @call-super!

  single: ->
    @can-build.any-of \model \attribute \unknown \no-item

  parse-tupel: ->
    @[@tuple-type!]

  plural: ->
    @list-parser.plural! if @is-plural!

  # or key-type ?
  is-plural: ->
    @tuple-type-is.is-plural!
)