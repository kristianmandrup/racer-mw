Class       = require('jsclass/src/core').Class

requires = require '../../../requires'

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

CollectionPipe      = requires.apipe 'collection'
BasePipeBuilder     = requires.apipe-builder 'base'

# Must be on a model or attribute
CollectionsPipeBuilder = new Class(BasePipeBuilder,
  initialize: (@container) ->
    @call-super!
    @

  validate-container: ->
    @call-super!
    unless @container.pipe-type in ['Model', 'Path']
      throw new Error "collections can only be used on a Model- or PathPipe, was: #{@container.pipe-type}"

  type: 'Builder'
  builder-type: 'Collections'

  create-pipe: (...args) ->
    @call-super!
    new CollectionPipe ...args
)

module.exports = CollectionsPipeBuilder