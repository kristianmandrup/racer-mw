Class       = require('jsclass/src/core').Class

requires = require '../../requires'

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

AttributePipe         = requires.pipe 'attribute'

# Must be on a model or attribute
AttributesPipe = new Class(
  initialize: (@parent-pipe) ->
    @validate!

  validate: ->
    unless typeof @parent-pipe is 'object'
      throw new Error "Attributes can only be used on a Pipe Object, was: #{@parent-pipe}"

    unless @parent-pipe.type is 'Pipe'
      throw new Error "Attributes can only be used on a Pipes, was: #{@parent-pipe}"

    unless @parent-pipe.pipe-type is 'Model'
      throw new Error "Attributes can only be used on a Model pipes, was: #{@parent-pipe.pipe-type}"

  pipe-type: 'Attributes'

  add: ->
    @added = @create-pipe arguments
    @parent-pipe.attach @added
    @

  create-pipe: ->
    switch arguments.length
    case 0
      throw new Error "Must take an argument"
    case 1
      new AttributePipe arguments[0]
    case 2
      new AttributePipe arguments[0], arguments[1]
    default
      throw new Error "Too many arguments, #{arguments}"
)

module.exports = AttributesPipe