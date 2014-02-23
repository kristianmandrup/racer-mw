Class   = require('jsclass/src/core').Class

requires      = require '../../requires'
lo            = require 'lodash'
_             = require 'prelude-ls'

CommandParser  = requires.racer 'command/parser'

# new RacerCommand(@resource).run(action).pass hash
RacerCommand = new Class(
  initialize: (resource) ->
    @validate-args resource
    @resource = resource
    @

  validate-args: (resource) ->
    unless resource
      throw new Error "Missing resource argument"

    unless typeof resource is 'object'
      throw new Error "Resource argument must be an Object, was: #{resource} [#{typeof resource}"


  run: (action) ->
    unless typeof action is 'string'
      throw new Error "Run expects an action of type String, was: #{action} [#{typeof action}"

    @action = action
    @

  middleware: ->

  mw-context: ->


  pass: (hash) ->
    @command-args = @command-parser(hash).extract!

  command-parser: (hash) ->
    new CommandParser(@action, hash)
)

module.exports = RacerCommand
