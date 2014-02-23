Class   = require('jsclass/src/core').Class

requires      = require '../../requires'
lo            = require 'lodash'
_             = require 'prelude-ls'

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