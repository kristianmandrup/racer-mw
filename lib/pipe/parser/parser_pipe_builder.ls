Class       = require('jsclass/src/core').Class

requires = require '../../requires'

PipeParser    = requires.pipe 'pipe_parser'

ParserPipeBuilder = new Class(
  initialize: (@parser, @value) ->
    @

  # arg is usually a string key
  build: (type, arg) ->
    new parsed-builder(type, @value).build arg

  parsed-builder: (type) ->
    requires.pipe "parser/builder_#{type}_builder"
)

module.exports = ParserPipeBuilder