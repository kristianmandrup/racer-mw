requires = require '../../../../requires'

Class       = require('jsclass/src/core').Class

util  = require 'util'
require 'sugar'

TupleBaseParser = requires.pipe 'parser/tuple/tuple_base_parser'

TupleObjectParser = new Class(TupleParser,
  initialize: (@key, @value) ->
    @call-super!

  parse-single: ->
    @validate-string-key!
    @model! or @attribute! or @unknown! @none!

  model: ->
    @build 'model' if @is-model!

  attribute: ->
    @build 'attribute' if @is-model!

  unknown: ->
    @build 'model' if @is-unknown!

  none: ->
    throw new Error "Single value for #{@key} should be Object, Number or String, was: #{typeof! @value}, #{@value}"

  is-unknown: ->
    typeof! @value is 'Undefined'

  is-model: ->
    typeof! @value is 'Object'

  is-attribute: ->
    typeof! @value in @primitive-types

  parse-path: ->
    @build 'children', @path-pipe!

  path-pipe: ->
    new PathPipe @key

  parse-tupel: ->
    @plural! or @parse-method!

  plural: ->
    @list-parser.parse-plural! if @tuple-type! is 'Plural'

  parse-method: ->
    @["parse#{@tuple-type!}"]

  tuple-type: ->
    @validate-string-key!
    @is-path! or @is-single! or @is-plural! or @is-none!

  is-path: ->
    'Path' if @key[0] in ['_', '$']

  is-single: ->
    'Single' if @key.singularize! is @key

  is-plural: ->
    'Plural' if @key.pluralize! is @key

  is-none: ->
    throw new Error "Can't determine tupel type from key: #{@key}"
)