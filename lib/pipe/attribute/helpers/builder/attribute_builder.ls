Class       = require('jsclass/src/core').Class

get   = require '../../../../requires' .get!

lo    = require 'lodash'
require 'sugar'

BasePipeBuilder   = get.container-builder 'base'
AttributeAdder    = get.attribute  'builder/attribute_adder'

AttributePipeBuilder = new Class(BasePipeBuilder,
  initialize: (@container) ->
    @call-super!
    @

  type: 'Builder'
  builder-type: 'Attribute'

  # attach an attribute pipe as a child
  build: (...@args) ->
    @attach @pipes

  pipes: ->
    @build-one! or @build-many!

  build-one: ->
    @add-attribute @first-arg!

  first-arg: ->
    @args.1 if @args.length is 1

  # map each arg in list
  build-many: ->
    lo.map @args, @build-one

  # value, name or both!?
  add-attribute: (value) ->
    @attribute-adder!.add value

  attribute-adder: ->
    new AttributeAdder(@)
)

module.exports = AttributePipeBuilder