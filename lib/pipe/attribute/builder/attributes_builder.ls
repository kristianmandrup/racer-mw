Class  = require('jsclass/src/core').Class
get    = require '../../../../requires' .get!
lo     = require 'lodash'
require 'sugar'

AttributePipe       = get.apipe 'attribute'
BasePipeBuilder     = get.base-builder 'base'

# Must be on a model or attribute
AttributesPipeBuilder = new Class(BasePipeBuilder,
  initialize: (@container) ->
    @call-super!
    @

  validate: ->
    @call-super!
    @validate-container!

  validate-container: ->
    unless @container.allows-child 'attribute'
      throw new Error "Parent Pipe #{@container.pipe-type} may not contain any Attribute pipe, only: #{@container.valid-children}"

  type: 'Builder'
  builder-type: 'Attributes'

  create-pipe: (...args) ->
    @call-super!
    new AttributePipe ...args
)

module.exports = AttributesPipeBuilder