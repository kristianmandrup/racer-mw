# Validates if object is a Pipe and optionally kind of pipe
# Reusable in many places

Class       = require('jsclass/src/core').Class

require 'sugar'
util  = require 'util'
_     = require 'prelude-ls'
lo    = require 'lodash'

PipeValidator = new Class(
  initialize: (@obj, @valid-types = []) ->
    @is-obj!
    @pipe-type = @obj.pipe-type unless typeof! @obj is 'Array'

  validate: ->
    return @validate-many @obj if typeof! @obj is 'Array'
    @is-pipe!
    @validate-types!

  is-obj: ->
    unless typeof @obj is 'object'
      throw new Error "Must be an Object or Array, was: #{typeof! @obj}"
    true

  is-pipe: ->
    unless @obj.type is 'Pipe'
      throw new Error "Must be a type: Pipe, was: #{@obj.type}"

    unless typeof! @pipe-type is 'String'
      throw new Error "Must be kind of Pipe, missing pipe-type"
    true

  validate-many: (objs) ->
    for obj in objs.flatten!.compact!
      new PipeValidator obj, @valid-types
    true

  validate-types: ->
    return if lo.is-empty @valid-types
    unless @pipe-type in @valid-types
      throw new Error "Pipe must be one of: #{@valid-types}, was #{@pipe-type}"
    true
)

module.exports = PipeValidator