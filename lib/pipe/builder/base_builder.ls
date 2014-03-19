Class       = require('jsclass/src/core').Class

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'

describe = (obj) ->
  return obj.describe! if _.is-type 'Function', obj.describe
  util.inspect obj

BasePipeBuilder = new Class(
  initialize: (@container) ->
    @validate-container!
    @

  validate: ->
    unless typeof @parent-pipe is 'object'
      throw new Error "Attributes can only be used on a Pipe Object, was: #{@parent-pipe}"

    unless @parent-pipe.type is 'Pipe'
      throw new Error "Attributes can only be used on a Pipes, was: #{@parent-pipe}"

  validate-container: ->
    unless _.is-type 'Object', @container
      throw new Error "Must be an object, was: #{describe @container}"

    unless _.is-type 'Function', @container.attach
      throw new Error "Must have an attach function, was: #{describe @container}"

  attach: (pipe) ->
    @container.attach pipe
    @post-attach(pipe)

  post-attach: (pipe) ->

  add: (...args)->
    pipe = @create-pipe ...args
    @push pipe
    @attach pipe
    @

  push: (pipe) ->
    @added ||= []
    @added.push pipe

  first: ->
    @added.first!

  last: ->
    @added.last!

  clear: ->
    @added = []
)

module.exports = BasePipeBuilder