Class       = require('jsclass/src/core').Class

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'

requires = require '../../../../requires'

describe = (obj) ->
  return obj.describe! if _.is-type 'Function', obj.describe
  util.inspect obj, depth: 1

PipeValidation      = requires.pipe 'pipe_validation'

BasePipeBuilder = new Class(
  include:
    * PipeValidation
    ...

  initialize: (@container) ->
    @validate-container!
    @

  validate-container: ->
    @is-pipe @container

    unless _.is-type 'Function', @container.attach
      throw new Error "Must have an attach function, was: #{describe @container}"

  attach: (pipe) ->
    @container.attach pipe
    @post-attach(pipe)

  post-attach: (pipe) ->

  add: (...args) ->
    @set @create-pipe ...args

  parse: (...args) ->
    Parser = requires.pipe 'pipe_parser'
    parser = new Parser(args, parent: @container)
    @set parser.parse!

  set-many: (pipes) ->
    for pipe in pipes
      @set pipe

  set: (pipe) ->
    @set-many(pipe.flatten!.compact!) if typeof! pipe is 'Array'
    @push pipe
    @attach pipe
    pipe

  build: (...args)->
    @add ...args

  push: (pipe) ->
    @added ||= []
    @added.push pipe

  create-pipe: (...args) ->
    return @create-pipes(args.first!) if _.is-type 'Array', args.first!
    @parse ...args

  create-pipes: (list) ->
    self = @
    list.map (item) ->
      self.create-pipe item

  first: ->
    @added.first!

  last: ->
    @added.last!

  clear: ->
    @added = []
)

module.exports = BasePipeBuilder