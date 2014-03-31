requires = require '../../../requires'

Class       = require('jsclass/src/core').Class

PipeValidation    = requires.pipe 'pipe_validation'
Debugging         = requires.lib 'debugging'

BaseParser = new Class(
  include:
    * Debugging
    * PipeValidation
    ...

  initialize: (@parent-pipe, @value) ->
    @is-pipe @parent-pipe
    @pipe-type = @parent-pipe.pipe-type
    @

  parent-type: ->
    @parent-pipe.pipe-type

  parse: ->
    throw new Error "Must be implemented by subclass"
)

module.exports = BaseParser
