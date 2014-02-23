Class   = require('jsclass/src/core').Class

requires      = require '../../../requires'
lo            = require 'lodash'
_             = require 'prelude-ls'
require 'sugar'
util = require 'util'

ArgStore            = requires.resource 'arg/store'
ArgumentsExtractor  = requires.racer    'command/arg_extractor'

CommandParser = new Class(
  initialize: (@command-name, @arg-hash) ->
    @validate-args!
    @command-map = @arg-store!.repo
    @

  arg-store: ->
    new ArgStore

  validate-args: ->
    unless @command-name
      throw new Error "Missing arguments, must take a command name and an argument hash"

    unless typeof @command-name is 'string'
      throw new Error "Command name argument must be a String, was: #{@command-name}"

    unless typeof @arg-hash is 'object'
      throw new Error "Argument hash must be an Object, was: #{@arg-hash}"

  extract: ->
    @extractor!.extract!

  rule: ->
    @command-rule @command-name

  extractor: ->
    new ArgumentsExtractor @rule!, @arg-hash

  # name is command-name
  command-rule: (name) ->
    unless @command-map[name]
      throw new Error "No rule for #{name} in command map: #{util.inspect @command-map, depth: 2}"
    @command-map[name]
)

module.exports = CommandParser