Class       = require('jsclass/src/core').Class

requires = require '../../../requires'

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

AttributePipe       = requires.apipe 'attribute'
BasePipeBuilder     = requires.apipe-builder 'base'

# Must be on a model or attribute
AttributesPipeBuilder = new Class(BasePipeBuilder,
  initialize: (@container) ->
    @call-super!
    @

  validate: ->
    @call-super!
    unless 'attribute' in @container.valid-children
      throw new Error "Parent Pipe #{@container.pipe-type} may not contain any Attribute pipe, only: #{@container.valid-children}"

  type: 'Builder'
  builder-type: 'Attributes'

  create-pipe: ->
    args = _.values(arguments)
    first-arg = args.first!
    switch arguments.length
    case 0
      throw new Error "Must take an argument"
    case 1
      new AttributePipe first-arg
    case 2
      new AttributePipe first-arg, args.last!
    default
      throw new Error "Too many arguments, #{args}"
)

module.exports = AttributesPipeBuilder