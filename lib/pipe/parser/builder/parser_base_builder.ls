Class       = require('jsclass/src/core').Class

requires = require '../../../../requires'

PipeValidation      = requires.pipe 'pipe_validation'
ParserBaseBuilder   = requires.pipe 'parser/builder/parser_base_builder'
ParserPipeBuilder   = requires.pipe 'parser/parser_pipe_builder'

ParserBaseBuilder = new Class(
  include:
    * PipeValidation
    ...

  initialize: (@parser, @value)->

  build: (arg) ->
    throw new Error "Must be implemented by sublclass"

  build-children: (parent) ->
    @parser-builder(@value).build 'children', parent

  parser-builder: ->
    new ParserPipeBuilder @parser, @value
)

module.exports = ParserBaseBuilder