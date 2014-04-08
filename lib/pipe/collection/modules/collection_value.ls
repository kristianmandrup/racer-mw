Class       = require('jsclass/src/core').Class

requires  = require '../../../../requires'

_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

# See TestCase!
CollectionValue = new Module(
  # overrides create-value-obj in PipeValue module
  # Uses special ValueObject for Collection
  # Can f.ex use the at: index option
  create-value-obj: ->
    new ArrayValueObject @

  set-value: (value, options = {}) ->
    @call-super value
    # depends on whether one or more of the children the match the Array are already there

    # builder = @builder-for(value)
    # builder.build value
    # @raw-value!

  set-value-at: (hash) ->
    @value-hash-setter!.set-value hash

  value-hash-setter: ->
    @hash-setter ||= new ValueHashSetter @

  get-value: ->
    lo.map @child-values, @child-value

  child-value: (child) ->
    child.value!

  child-values: ->
    _.values @children
)

module.exports = CollectionValue