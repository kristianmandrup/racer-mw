Class   = require('jsclass/src/core').Class

requires      = require '../../../requires'
lo            = require 'lodash'
_             = require 'prelude-ls'
require 'sugar'
util = require 'util'

ArgStore            = requires.resource 'arg/resource_arg_store'
ArgumentsExtractor  = requires.racer    'command/racer_command_arg_extractor'

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

    unless typeof! @command-name is 'String'
      throw new Error "Command name argument must be a String, was: #{@command-name}"

    return if @arg-hash is void

    unless typeof! @arg-hash is 'Object'
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
      throw new Error "No rule for #{name} in command map: #{_.keys @command-map}"
    @command-map[name]
)

module.exports = CommandParser