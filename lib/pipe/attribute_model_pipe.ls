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
    try
      @call-super!
      @set @first-arg
      @post-init!
    finally
      @

  pipe:
    type:       'AttributeModel'
    base-type:  'Model'

  id: ->
    return @name unless @name is void
    return @clazz unless @clazz is void
    throw new Error "Unable to determine id, please set either object-id or name"

  set: (obj) ->
    @set-class obj
    @set-name extract.name(obj, @clazz)
    @set-value extract.value(obj)

  set-class: (obj) ->
    @clazz = extract.clazz(obj)

  # don't use extract.value here!!
  set-value: (obj) ->
    @call-super obj

  pre-attach-to: (parent) ->
    @call-super!

  valid-parents:
    * \path
    * \model

  valid-children:
    * \attribute
    * \model-attribute
    * \collection
)

module.exports = ModelPipe