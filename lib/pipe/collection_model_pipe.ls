# TODO
# Refactor ModelPipe into CollectionModelPipe and AttributeModelPipe!!!

Class       = require('jsclass/src/core').Class

requires = require '../../requires'

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

ModelPipe               = requires.apipe 'base'

# Must be on a model or attribute
CollectionModelPipe = new Class(ModelPipe,
  initialize: (item) ->
    try
      @call-super!
      @set @first-arg
      @post-init!
    finally
      @

  pipe:
    type:       \CollectionModel
    base-type:  \Model

  id: ->
    String(@object-id) unless @object-id is void

  set: (obj) ->
    @set-class obj
    @set-value extract.value(obj)

  set-class: (obj) ->
    @clazz = extract.clazz(obj)

  # don't use extract.value here!!
  set-value: (obj) ->
    @call-super obj

  pre-attach-to: (parent) ->
    @call-super!
    @attacher!.attach-to parent

  attacher: ->
    new ParentAttacher @

  valid-parents:  <[path collection]>
  valid-children: <[attribute model-attribute collection]>
)

module.exports = ModelPipe