requires = require '../../../../requires'

Class       = require('jsclass/src/core').Class

util  = require 'util'
require 'sugar'

Debugging           = requires.lib 'debugging'
ParserBuilder       = requires.pipe 'parser/parser_builder'

TupleKeyTyper       = requires.pipe 'parser/tuple/typer/tuple_key_typer'
TupleValueTyper     = requires.pipe 'parser/tuple/typer/tuple_value_typer'
TupleListTyper      = requires.pipe 'parser/tuple/typer/tuple_list_typer'

TupleBuilder        = requires.pipe 'parser/tuple/tuple_builder'
TupleValidator      = requires.pipe 'parser/tuple/tuple_validator'

TupleBaseParser = new Class(
  include:
    * Debugging
    * TupleValidator

  initialize: (@key, @value) ->
    @validate-string-key!
    @list-typer   = new TupleListTyper @value
    @key-typer    = new TupleKeyTyper @key
    @value-typer  = new TupleValueTyper @value
    @

  builder: ->
    @_builder ||= new TupleBuilder @

  tuple-type: ->
    @key-typer.tuple-type!

  tuple-type-is: ->
    @tt-is     ||= @key-typer.tuple-type-is!

  key-type-is: ->
    @k-type   ||= @key-typer

  list-type-is: ->
    @l-type   ||= @list-typer

  list-is: ->
    @l-is     ||= @list-typer.list-is!

  value-is: ->
    @v-type   ||= @value-typer
)

module.exports = TupleBaseParser