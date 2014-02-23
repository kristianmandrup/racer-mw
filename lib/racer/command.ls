Class   = require('jsclass/src/core').Class

requires      = require '../../requires'
lo            = require 'lodash'
_             = require 'prelude-ls'


# new RacerCommand(@resource).run(action).with hash
RacerCommand = new Class(
  initialize: (@resource) ->

  run: (action) ->
    @action = action
    @

  with: (hash) ->
    @command-args = new CommandArgumentsParser(@action, hash).extract!
)


