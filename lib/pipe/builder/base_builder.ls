Class       = require('jsclass/src/core').Class

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'

describe = (obj) ->
  return obj.describe! if _.is-type 'Function', obj.describe
  util.inspect obj, depth: 1

BasePipeBuilder = new Class(
  initialize: (@container) ->
    @validate-container!
    @

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

  build: (...args)->
    @add ...args

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