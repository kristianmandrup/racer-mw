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
    @

  validate: ->
    unless typeof @parent-pipe is 'object'
      throw new Error "Attributes can only be used on a Pipe Object, was: #{@parent-pipe}"

    unless @parent-pipe.type is 'Pipe'
      throw new Error "Attributes can only be used on a Pipes, was: #{@parent-pipe}"

    unless @parent-pipe.pipe-type is 'Model'
      throw new Error "Attributes can only be used on a Model pipes, was: #{@parent-pipe.pipe-type}"

  pipe-type: 'Attributes'

  add: (...args)->
    pipe = @create-pipe ...args
    @_push pipe
    @parent-pipe.attach pipe
    @

  _push: (pipe) ->
    @added ||= []
    @added.push pipe

  first: ->
    @added.first!

  last: ->
    @added.last!

  create-pipe: ->
    args = _.values(arguments)
    first-arg = args.first!
    switch arguments.length
    case 0
      throw new Error "Must take an argument"
    case 1
      new AttributePipe first-arg
    case 2
      new AttributePipe first-arg, args.last!
    default
      throw new Error "Too many arguments, #{args}"
)

module.exports = AttributesPipe