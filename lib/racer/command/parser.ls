Class   = require('jsclass/src/core').Class

requires      = require '../../../requires'
lo            = require 'lodash'
_             = require 'prelude-ls'
require 'sugar'

ArgStore            = requires.resource 'arg/store'
ArgumentsExtractor  = requires.racer    'command/arguments_extractor'

CommandParser = new Class(
  initialize: (@command-name, @arg-hash) ->

  extract: ->
    @extractor(@command-rule @command-name).extract!

  extractor: (rule) ->
    new ArgumentsExtractor rule, @arg-hash

  # name is command-name
  command-rule: (name)->
    @command-map[name]

  command-map: ->
    new ArgStore.repo
)

module.exports = CommandParser