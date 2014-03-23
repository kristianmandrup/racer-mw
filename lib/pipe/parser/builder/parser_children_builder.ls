Class       = require('jsclass/src/core').Class

requires = require '../../../../requires'

ParserBaseBuilder   = requires.pipe 'parser/builder/parser_base_builder'

PipeParser    = requires.pipe 'pipe_parser'

ParserChildrenBuilder = new Class(ParserBaseBuilder,
  initialize: (@value)->
    @call-super!

  build: (parent-pipe) ->
    try
      @is-pipe @parent-pipe
      pipes = new PipeParser(@value, parent: parent-pipe, debug: @debug).parse!
      parent-pipe.attach pipes
      parent-pipe
    catch e
      @debug-msg @value
      console.log e
      @debug-msg "unable to attach more pipes to: #{parent-pipe.describe!}"
      parent-pipe
    finally
      parent-pipe
)

module.exports = ParserChildrenBuilder
