Class = require('jsclass/src/core').Class
lo    = require 'lodash'
get   = require '../../../../requires' .get!

PipeValidation  = get.base-module 'validation'
PipeParser      = get.container-helper 'parse'

PipeAddHelper = new Class(
  include:
    * PipeValidation
    ...

  initialize: (@pipe) ->
    @is-pipe!
    @clear-added!
    @

  build: (...@args) ->
    @create-pipe!

  add: (...@args) ->
    @attach @create-pipe!
    @

  attach: (pipe) ->
    @pipe.attach pipe
    @added.push pipe

  create-pipe: ->
    @create-pipes!parse!

  list: ->
    @args.1 if @is-list!

  is-list: ->
    typeof! args.1 is 'Array'

  create-pipes: ->
    lo.map @list, @create-pipe, @
    @

  clear-added: ->
    @added = []

  parse: ->
    @set @parser.parse!

  parser: ->
    new PipeParser @args, parent: @container
)

module.exports = PipeAddHelper