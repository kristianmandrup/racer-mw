Class       = require('jsclass/src/core').Class

requires = require '../../../requires'

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

PipeFactory = new Class(
  initialize: (@value-object, @options = {}) ->
    unless typeof @value-object is 'object'
      throw new Error "Missing value-object argument, was: #{arguments}"

    unless typeof @options is 'object'
      throw new Error "Options argument must be an Object (has), was: #{@options}"

    # TODO: more options validation?
    @type     = @options.type
    @parent   = @options.parent

  create-pipe: ->
    @value-object.$pipe = new Pipe(@value-object)
    @value-object.$p = Pipe.$p # from local Node module scope
    @value-object.$queries = new Queries(@value-object)

  set-mw: ->
    switch @type
    case 'model'
      return
    default
      @value-object.$resource.mw-stack.remove ['validator', 'authorizer']
)

module.exports = PipeFactory