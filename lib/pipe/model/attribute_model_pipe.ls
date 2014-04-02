# TODO
# Refactor ModelPipe into CollectionModelPipe and AttributeModelPipe!!!

Class       = require('jsclass/src/core').Class

requires = require '../../requires'

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

ModelPipe               = requires.apipe 'model'

# Must be on a model or attribute
AttributeModelPipe = new Class(ModelPipe,
  initialize: ->
    @call-super!
    @set-all!
    @post-init!

  pipe:
    type:       'AttributeModel'
    base-type:  'Model'

  id: ->
    @name or @no-id!

  no-id: ->
    throw new Error "Unable to determine id, please set either object-id or name"

  pre-attach-to: (parent) ->
    @call-super!

  valid-parents:  <[path attribute-model]>
  valid-children: <[attribute attribute-model collection]>
)

module.exports = ModelPipe