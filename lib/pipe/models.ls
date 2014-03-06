Class       = require('jsclass/src/core').Class

requires = require '../../requires'

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

ModelPipe         = requires.pipe 'model'

# Must be on a model or attribute
ModelsPipe = new Class(
  initialize: (@parent-pipe) ->
    @validate!

  validate: ->
    unless typeof @parent-pipe is 'object'
      throw new Error "Models can only be used on a Pipe Object, was: #{@parent-pipe}"

    unless @parent-pipe.type is 'Pipe'
      throw new Error "Models can only be used on a Pipes, was: #{@parent-pipe}"

    unless @parent-pipe.pipe-type in ['Model', 'Collection']
      throw new Error "Models can only be used on a Model or Collection, was: #{@parent-pipe.pipe-type}"

  add: ->
    @added =  @create-pipe arguments
    @parent-pipe.attach @added
    @

  pipe-type: 'Models'

  create-pipe: ->
    switch arguments.length
    case 0
      throw Error "Must take an argument"
    case 1
      new ModelPipe arguments[0]
    case 2
      new ModelPipe arguments[0], arguments[1]
    default
      throw Error "Too many arguments, #{arguments}"
)

module.exports = ModelsPipe