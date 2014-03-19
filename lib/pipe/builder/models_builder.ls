Class       = require('jsclass/src/core').Class

requires = require '../../../requires'

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

ModelPipe           = requires.apipe 'model'
BasePipeBuilder     = requires.apipe-builder 'base'

# Must be on a model or attribute
ModelsPipeBuilder = new Class(BasePipeBuilder,
  initialize: (@parent-pipe) ->
    @validate!
    @

  validate: ->
    @call-super!
    unless 'model' in @parent-pipe.valid-children
      throw new Error "Parent Pipe #{@parent-pipe.pipe-type} may not contain any Model pipe, only: #{@parent-pipe.valid-children}"

  type: 'Builder'
  builder-type: 'Models'

  create-pipe: ->
    args = _.values(arguments)
    first-arg = args.first!
    switch args.length
    case 0
      throw Error "Must take an argument"
    case 1
      console.log 'ModelPipe', ModelPipe
      new ModelPipe first-arg
    case 2
      new ModelPipe first-arg, args.last!
    default
      throw Error "Too many arguments, #{args}"
)

module.exports = ModelsPipeBuilder