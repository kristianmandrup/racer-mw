Class   = require('jsclass/src/core').Class

requires      = require '../../requires'
lo            = require 'lodash'
_             = require 'prelude-ls'

ArgStore = requires.resource 'arg/store'

ArgumentsExtractor = new Class(
  initialize: (@rule, @arg-hash) ->

  result-args: []

  extract: ->
    # first extract required...
    @extract-required if @rule.required

  extract-required: ->
    self = @
    @rule.required.each (req) ->
      unless @arg-hash[req]
        throw new Error "Missing required argument #{req} in: #{@arg-hash}"
      self.result-args.push @arg-hash[req]

  extract-optional: ->
    self = @
    @rule.optional.each (opt) ->
      if @arg-hash[opt]
        self.result-args.push @arg-hash[opt]
)

CommandArgumentsParser = new Class(
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

module.exports = CommandArgumentsParser