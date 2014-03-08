Class       = require('jsclass/src/core').Class

requires = require '../../../requires'

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

CollectionPipe      = requires.apipe 'collection'
BasePipeBuilder     = requires.apipe-builder 'base'

# Must be on a model or attribute
CollectionsPipeBuilder = new Class(BasePipeBuilder,
  initialize: (@parent-pipe) ->
    @validate!
    @

  validate: ->
    @call-super!
    unless @parent-pipe.pipe-type in ['Model', 'Path']
      throw new Error "collections can only be used on a Model- or PathPipe, was: #{@parent-pipe.pipe-type}"

  type: 'Builder'
  builder-type: 'Collections'

  create-pipe: ->
    args = _.values(arguments)
    first-arg = args.first!
    switch args.length
    case 0
      throw Error "Must take an argument"
    case 1
      new CollectionPipe first-arg
    default
      new CollectionPipe args
)

module.exports = CollectionsPipeBuilder