Class   = require('jsclass/src/core').Class

requires      = require '../../../requires'
lo            = require 'lodash'
_             = require 'prelude-ls'
require 'sugar'

ArgStore            = requires.resource 'arg/store'
ArgumentsExtractor  = requires.racer    'command/arg_extractor'

CommandParser = new Class(
  initialize: (@command-name, @arg-hash) ->
    @validate-args!
    @

  validate-args: ->
    unless @command-name
      throw new Error "Missing arguments, must take a command name and an argument hash"

    unless typeof @command-name is 'string'
      throw new Error "Command name argument must be a String, was: #{@command-name}"

    unless typeof @arg-hash is 'object'
      throw new Error "Argument hash must be an Object, was: #{@arg-hash}"

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