# Validates if object is a Pipe and optionally kind of pipe
# Reusable in many places

Class       = require('jsclass/src/core').Class

require 'sugar'
util  = require 'util'
_     = require 'prelude-ls'
lo    = require 'lodash'

PipeValidator = new Class(
  initialize: (@obj, @valid-types = []) ->
    @validate!
    @configure!
    @

  configure: ->
    @pipe-type = @obj.pipe-type

  validate: ->
    @validate-many! or @validate-pipe!

  validate-pipe: ->
    @is-pipe!
    @validate-types!
    true

  is-array: ->
    typeof! @obj is 'Array'

  is-object: ->
    typeof! @obj is 'Object'

  validate-obj-type: ->
    unless @is-array! or @is-object!
      throw new Error "Must be an Object or Array, was: #{typeof! @obj}"
    true

  is-pipe: ->
    @validate-obj!
    @validate-obj-type!
    @validate-pipe-type!

  validate-obj: ->
    unless @obj.type is 'Pipe'
      throw new Error "Must be a type: Pipe, was: #{@obj.type}"

  validate-pipe-type: ->
    unless @valid-pipe-type!
      throw new Error "Must be kind of Pipe, missing pipe-type"
    true

  valid-pipe-type: ->
    typeof! @pipe-type is 'String'

  validate-many: (objs) ->
    return unless @is-array!
    for obj in objs.flatten!.compact!
      new PipeValidator obj, @valid-types
    true

  validate-types: ->
    @type-validator!.validate @pipe-type

  type-validator: ->
    @tvalidator ||= new PipeTypeValidator @valid-types
)

module.exports = PipeValidator