Class   = require('jsclass/src/core').Class

requires      = require '../../requires'
lo            = require 'lodash'
_             = require 'prelude-ls'

CommandParser  = requires.racer 'command/parser'

# new RacerCommand(@resource).run(action).with hash
RacerCommand = new Class(
  initialize: (@resource) ->

  run: (action) ->
    @action = action
    @

  with: (hash) ->
    @command-args = new CommandParser(@action, hash).extract!
)


