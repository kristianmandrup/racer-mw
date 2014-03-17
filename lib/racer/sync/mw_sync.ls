Class   = require('jsclass/src/core').Class

requires      = require '../../requires'
lo            = require 'lodash'
_             = require 'prelude-ls'
util          = require 'util'

RacerCommand  = requires.racer 'command'
BaseSync      = requires.racer 'sync/base_sync'

arg-error = ->
  throw new Error "Argument racer-command must be a RacerCommand instance, was: #{util.inspect command} [#{typeof command}]"

MwSync = new Class(BaseSync,
  initialize: (racer-command) ->
    @call-super!

  current-user: ->
    # the model of the session user
    @_current-user ||= @racer-store.get '_session.user'

  # middleware:
  #  - see middleware and model-mw projects. A complete configured middleware stack, depending on the CRUD action
  #     about to be executed (depending of the type of racer store command)
  # mw-context:
  # - a hash with everything needed to run the middleware
  # - possibly enrich with current-user if not set (if authorization) ??

  middleware: ->
    @racer-command.middleware!

  run-args: ->
    @racer-command.mw-context!

  execute: ->
    @middleware!.run @run-args
)

module.exports = MwSync