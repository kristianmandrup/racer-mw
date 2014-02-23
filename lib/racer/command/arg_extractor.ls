Class   = require('jsclass/src/core').Class

requires      = require '../../../requires'
lo            = require 'lodash'
_             = require 'prelude-ls'
require 'sugar'

ArgumentsExtractor = new Class(
  initialize: (@rule, @arg-hash) ->
    @clear!
    @validate-args!
    @

  clear: ->
    @result-args = []

  validate-args: ->
    unless @rule
      throw new Error "Missing arguments, must take a rule Object and an argument Object (hash)"

    unless typeof @rule is 'object'
      throw new Error "rule argument must be an Object, was: #{@rule}"

    unless typeof @arg-hash is 'object'
      throw new Error "Argument hash must be an Object, was: #{@arg-hash}"

  required-args: ->
    return [] unless @rule.required
    @req ||= [@rule.required].flatten!

  optional-args: ->
    return [] unless @rule.optional
    @opt ||= [@rule.optional].flatten!


  extract: ->
    @clear!
    # first extract required...
    @extract-required!
    @extract-optional!
    @result-args

  extract-required: ->
    return if lo.is-empty @required-args!
    self = @
    @required-args!.each (req) ->
      unless self.arg-hash[req]
        throw new Error "Missing required argument #{req} in: #{self.arg-hash}"
      self.result-args.push self.arg-hash[req]
    @

  extract-optional: ->
    return if lo.is-empty @optional-args!
    self = @
    @optional-args!.each (opt) ->
      if self.arg-hash[opt]
        self.result-args.push self.arg-hash[opt]
    @
)

module.exports = ArgumentsExtractor