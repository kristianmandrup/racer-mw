Class   = require('jsclass/src/core').Class

requires      = require '../../../requires'
lo            = require 'lodash'
_             = require 'prelude-ls'
util          = require 'util'

RacerCommand    = requires.racer 'racer_command'

arg-error = ->
  throw new Error "Argument racer-command must be a RacerCommand instance, was: #{util.inspect command} [#{typeof command}]"

BaseSync = new Class(
  extend: requires.racer('racer_store_config')

  initialize: (command) ->
    @validate-arg command
    @command = command
    @racer-store = BaseSync.racer-store!
    @racer-model = BaseSync.racer-model!
    @

  validate-arg: (command) ->
    unless command
      throw new Error "Missing racer-command argument, #{command}"

    unless typeof command is 'object'
      arg-error command

    unless command.klass is RacerCommand
      arg-error command

    unless command.action
      throw new Error "RacerCommand #{util.inspect command} is missing an: action. Please use: .run(action)"

    # TODO: if command action requires args?
    # already validated ?
    # unless command.command-args
      # throw new Error "RacerCommand #{util.inspect command} is missing: command-args, Please use: .run(action).using args"

  racer-command: ->
    @racer-model[@command-name!]

  racer-execute: ->
    @racer-command!.apply @racer-model, @command-args!

  execute: ->
    @racer-execute!

  command-args: ->
    @command.command-args

  command-name: ->
    @command.action
)

module.exports = BaseSync