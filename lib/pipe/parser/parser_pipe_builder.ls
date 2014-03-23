Class       = require('jsclass/src/core').Class

requires = require '../../../requires'

PipeParser    = requires.pipe 'pipe_parser'

ParserPipeBuilder = new Class(
  initialize: (@parser, @value) ->
    unless @parser.parse
      throw new Error "First argument must be the original Parser, was: #{@parser}"
    @

  # arg is usually a string key
  build: (type, arg) ->
    clazz = @parser-builder(type)
    console.log 'clazz', clazz
    new clazz(@value).build arg

  parser-builder: (type) ->
    requires.pipe "parser/builder/parser_#{type}_builder"
)

module.exports = ParserPipeBuilder