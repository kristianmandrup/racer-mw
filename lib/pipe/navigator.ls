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
    @walk.call @pipe, 'parent', steps

  root: ->
    @walk.call @pipe, 'parent', 9

  # calling 'meth' on 'obj' repeatedly for 'steps' steps or untill undefined is reached
  walk: (meth, steps) ->
    if steps > 10
      throw Error "Warning: You should NEVER have more than 10 pipes in a model path! Try to flatten your model a little..."
    inner-walk @pipe, steps

  inner-walk: (obj, steps) ->
    return obj if steps is 0
    return obj if obj is void
    next = obj[meth]!
    if next isnt void then @inner-walk(next, --steps) else obj
)

module.exports = PipeNavigator