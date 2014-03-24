Class       = require('jsclass/src/core').Class

requires = require '../../../../requires'

ParserBaseBuilder   = requires.pipe 'parser/builder/parser_base_builder'

PipeParser    = requires.pipe 'pipe_parser'

ParserChildrenBuilder = new Class(ParserBaseBuilder,
  initialize: (@parser, @value, @options = {}) ->
    @call-super!

  build: (@parent, @value) ->
    @is-pipe @parent
    return @parent if @value is void
    @parse-value!

  parse-value: ->
    @parent.attach @parsed-pipes!
    @parent

  parsed-pipes: ->
    @pipe-parser!.parse @value

  pipe-parser: ->
    new PipeParser parent: @parent, debug: @debug
)

module.exports = ParserChildrenBuilder
