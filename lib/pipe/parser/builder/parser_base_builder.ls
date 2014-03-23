Class       = require('jsclass/src/core').Class

requires = require '../../requires'

ParserPipeBuilder = requires.pipe 'parser/parser_pipe_builder'

ParserBaseBuilder = new Class(
  initialize: (@value)->

  build: (arg) ->
    throw new Error "Must be implemented by sublclass"

  build-children: (parent) ->
    @parser-builder(@value).build 'children', parent

  parser-builder: ->
    new ParserPipeBuilder @, @value
)

