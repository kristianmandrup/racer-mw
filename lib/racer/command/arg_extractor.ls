Class   = require('jsclass/src/core').Class

requires      = require '../../../requires'
lo            = require 'lodash'
_             = require 'prelude-ls'
require 'sugar'

ArgumentsExtractor = new Class(
  initialize: (@rule, @arg-hash) ->
    @validate-args!
    @

  validate-args: ->
    unless typeof @rule is 'object'
      throw new Error "Missing rule as 1st argument, was: #{arguments}"

    unless typeof @arg-hash is 'object'
      throw new Error "Missing argument hash as 2nd argument, was: #{arguments}"

  result-args: []

  extract: ->
    # first extract required...
    @extract-required if @rule.required
    @extract-optional if @rule.optional

  extract-required: ->
    return unless typeof @rule.required is 'array'
    self = @
    @rule.required.each (req) ->
      unless @arg-hash[req]
        throw new Error "Missing required argument #{req} in: #{@arg-hash}"
      self.result-args.push @arg-hash[req]
    @

  extract-optional: ->
    return unless typeof @rule.optional is 'array'
    self = @
    @rule.optional.each (opt) ->
      if @arg-hash[opt]
        self.result-args.push @arg-hash[opt]
    @
)

module.exports = ArgumentsExtractor