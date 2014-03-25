requires = require '../../../requires'

Class       = require('jsclass/src/core').Class

PipeValidation    = requires.pipe 'pipe_validation'
Debugging         = requires.lib 'debugging'

BaseParser = new Class(
  include:
    * Debugging
    * PipeValidation
    ...

  initialize: (@parser, @value) ->
    unless @parser and typeof! @parser.parse is 'Function'
      throw new Error "First arg must be a PipeParser, was: #{@parser}"
    @parent = @parser.parent
    @debug-on = @parser.debug-on
    @

  parse: ->
    throw new Error "Must be implemented by subclass"

  parent-type: ->
    @parent.pipe-type if @parent

  build: (type, arg, @value) ->
    builder = @create-builder(type)
    unless builder
      throw new Error "Builder #{type} could not be created"
    builder.build arg

  create-builder: (type) ->
    clazz = @builder-clazz(type)
    new clazz(@, @value)

  builder-clazz: (type) ->
    requires.pipe "parser/builder/parser_#{type}_builder"
)

module.exports = BaseParser
