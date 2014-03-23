Class       = require('jsclass/src/core').Class

requires = require '../../requires'

PipeParser    = requires.pipe 'pipe_parser'

ParserChildrenBuilder = new Class(
  initialize: ->

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
