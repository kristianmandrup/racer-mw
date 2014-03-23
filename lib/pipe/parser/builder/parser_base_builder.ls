Class       = require('jsclass/src/core').Class

requires = require '../../requires'

PipeValidation = requires.pipe 'validator/pipe_validation'

ParserBaseBuilder = new Class(
  initialize: (@value)->

  build: (arg) ->
    throw new Error "Must be implemented by sublclass"

  build-children: (parent) ->
    @parser-builder(@value).build 'children', parent

  parser-builder: ->
    new ParserPipeBuilder @, @value
)

