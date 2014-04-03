Module    = require('jsclass/src/core').Module
get       = require '../../../../requires' .get!
_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

PipeFamily = new Module(
  initialize: ->
    @clear!

  attr: (name) ->
    p = @child name
    @validate-attribute p, name

  validate-attribute: (p, name) ->
    unless p.pipe-type is 'Attribute'
      throw new Error "The child pipe #{name} is not an Attribute"

  modl: (name) ->
    p = @child name
    @validate-model name

  validate-model: (p, name) ->
    unless p.pipe-type is 'Model'
      throw new Error "The child pipe #{name} is not a Model"

  col: (name) ->
    p = @child name
    @validate-collection p, name

  validate-collection: (p, name) ->
    unless p.pipe-type is 'Collection'
      throw new Error "The child pipe #{name} is not a Collection"

  parent-name: ->
    if @parent then @parent.full-name else ''

  # subclass should override!
  valid-parents: []
  parent: void

  clear: ->
    @child-hash = {}
    @update-child-count!
    @
)

module.exports = PipeFamily
