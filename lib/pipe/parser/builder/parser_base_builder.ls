Class       = require('jsclass/src/core').Class

requires = require '../../../../requires'

PipeValidation      = requires.pipe 'pipe_validation'
BaseParser          = requires.pipe 'parser/base_parser'

ParserBaseBuilder = new Class(
  include:
    * PipeValidation
    ...

  initialize: (@parser, @value)->
    unless typeof! @parser.parse is 'Function'
      throw new Error "First arg must be a Parser, was: #{@parser}"
    @

  build: (arg) ->
    throw new Error "Must be implemented by sublclass"

  build-children: (parent) ->
    @parser-builder!.build 'children', parent

  parser-builder: ->
    new BaseParser @parser, @value
)

module.exports = ParserBaseBuilder