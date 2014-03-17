Class   = require('jsclass/src/core').Class

requires      = require '../../requires'
lo            = require 'lodash'
_             = require 'prelude-ls'
util          = require 'util'

RacerCommand    = requires.racer 'command'

arg-error = ->
  throw new Error "Argument racer-command must be a RacerCommand instance, was: #{util.inspect command} [#{typeof command}]"

BaseSync = new Class(
  extend: requires.racer('store_config')

  initialize: (racer-command) ->
    @validate-arg racer-command
    @racer-command = racer-command
    @racer-store = RacerSync.racer-store!

  validate-arg: (command) ->
    unless command
      throw new Error "Missing racer-command argument, #{command}"

    unless typeof command is 'object'
      arg-error command

    unless command.klass is RacerCommand
      arg-error command

  run-args: ->
    @racer-command.args!

  execute: ->
    @racer-store[@command-name!] @command-args!

  command-args: ->
    @racer-command.arguments

  command-name: ->
    @racer-command.name
)

module.exports = RacerSync