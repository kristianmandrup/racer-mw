Class       = require('jsclass/src/core').Class

requires = require '../../requires'

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

BasePipe                = requires.apipe 'base'
AttributePipe           = requires.apipe 'attribute'
CollectionPipe          = requires.apipe 'collection'
AttributesPipeBuilder   = requires.apipe-builder 'attributes'

extract           = requires.apipe-extractor 'model'

# Must be on a model or attribute
ModelPipe = new Class(BasePipe,
  initialize: ->
    @call-super!
    @set @first-arg
    @post-init!
    @

  pipe-type: 'Model'

  id: ->
    return String(@object-id) unless @object-id is void
    # if no parent, I must assume i am just a named attribute model
    return @name unless @name is void
    throw new Error "Unable to determine id, please set either object-id or name"

  set: (obj) ->
    @set-class obj
    @set-name extract.name(obj)
    @set-value obj

  set-class: (obj) ->
    @clazz = extract.clazz(obj)

  set-value: (obj) ->
    @call-super extract.value(obj)

  pre-attach-to: (parent) ->
    @call-super!
    if parent.pipe-type is 'Collection'
      @object-id = parent.next-child-id!
      @clazz = parent.name.singularize! if @clazz is void

  valid-parents:
    * \path
    * \collection

  valid-children:
    * \attribute
    * \model
    * \collection
)

module.exports = ModelPipe