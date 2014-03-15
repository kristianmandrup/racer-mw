Class     = require('jsclass/src/core').Class

_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

PipeNavigator = new Class(
  initialize: (@pipe) ->
    unless typeof @pipe is 'object' and @pipe.type is 'Pipe'
      throw new Error "Must be a Pipe, was: #{@pipe}"

  prev: (steps) ->
    @walk steps

  root: ->
    @walk 9

  # calling 'meth' on 'obj' repeatedly for 'steps' steps or until undefined is reached
  walk: (steps = 1) ->
    if steps > 10
      throw Error "Warning: You should NEVER have more than 10 pipes in a model path! Try to flatten your model a little..."
    @inner-walk @pipe, steps

  inner-walk: (pipe, steps) ->
    return pipe if steps is 0
    return pipe if pipe is void
    next = pipe.parent
    if next isnt void then @inner-walk(next, --steps) else pipe
)

module.exports = PipeNavigator