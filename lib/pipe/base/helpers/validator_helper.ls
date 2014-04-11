Class = require('jsclass/src/core').Class
get   = require '../../../../requires' .get!
util  = require 'util'
lo    = require 'lodash'
require 'sugar'

PipeTypeValidatorHelper = get.base-validator 'type'

PipeValidatorHelper = new Class(
  initialize: (@pipe, @valid-types = []) ->
    @validate!
    @

  configure: ->
    @pipe-type = @pipe.info?.type

  validate: ->
    @validate-obj-type!
    @validate-many! or @validate-pipe!

  validate-pipe: ->
    @is-pipe!
    @validate-types!

  is-obj: ->
    typeof @pipe is 'object'

  is-array: ->
    typeof! @pipe is 'Array'

  is-object: ->
    typeof! @pipe is 'Object'

  validate-obj-type: ->
    unless @is-obj!
      throw new Error "Pipe must be an Object or Array, was: #{typeof! @pipe}"
    true

  is-pipe: ->
    @validate-obj!
    @configure!
    @validate-obj-type!
    @validate-pipe-type!

  validate-obj: ->
    unless @pipe.type is 'Pipe'
      throw new Error "Pipe must be of type: Pipe, was: #{@pipe.type}"

  validate-pipe-type: ->
    unless @valid-pipe-type!
      throw new Error "Pipe must be a kind of Pipe, missing pipe-type #{util.inspect @pipe.info} - #{@pipe-type}"
    true

  valid-pipe-type: ->
    typeof! @pipe-type is 'String'

  validate-many: ->
    return unless @is-array!
    for pipe in @pipe.flatten!.compact!
      new PipeValidatorHelper pipe, @valid-types
    true

  validate-types: ->
    @type-validator!.validate @pipe-type

  type-validator: ->
    @_type-validator ||= new PipeTypeValidatorHelper @valid-types
)

module.exports = PipeValidatorHelper