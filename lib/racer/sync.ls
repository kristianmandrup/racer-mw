Class   = require('jsclass/src/core').Class

requires      = require '../../requires'
lo            = require 'lodash'
_             = require 'prelude-ls'
util          = require 'util'

BaseSync      = requires.racer 'sync/base_sync'

RacerSync = new Class(
  initialize: (@options = {}) ->

  # create Sync based on options
  create: (command) ->
    new BaseSync command

)

module.exports = RacerSync