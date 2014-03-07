Class       = require('jsclass/src/core').Class

requires = require '../../requires'

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

BasePipe          = requires.pipe 'base'
AttributePipe     = requires.pipe 'attribute'
CollectionPipe    = requires.pipe 'collection'
AttributesPipe    = requires.pipe 'attributes'

CollectionBuilder = requires.builder 'collection'
ModelBuilder      = requires.builder 'model'
AttributeBuilder  = requires.builder 'attribute'

# no need for a child validator :)
# any attachment is always to a parent - simply validate parent is valid for child
# no need to validate reverse relationship - is implicit :)
ParentValidator   = requires.pipe 'validator/parent'

obj-name = (obj) ->
  if obj._clazz
    obj._clazz
  else
    _.keys(obj).first!

# Must be on a model or attribute
ModelPipe = new Class(BasePipe,
  # admin: {_clazz: 'user'}
  #   => name = 'admin', value-object = {_clazz: 'user'}
  # {_clazz: 'user'}
  #   => name = 'user', value-object = {_clazz: 'user'}
  initialize: ->
    @call-super!
    first-arg = [@args].flatten!.first!
    # TODO: array is also an object, we need a better way! lodash method?
    obj = first-arg if _.is-type 'Object', first-arg
    unless obj
      throw new Error "ModelPipe constructor must take an Object argument, was: #{@args}"

    @set-name obj-name(obj)
    @set-value obj
    @post-init!
    @config-builders!
    @

  config-builders: ->
    @builders = {}
    @builders['collection']   = new CollectionBuilder @
    @builders['model']        = new ModelBuilder @
    @builders['attribute']    = new ModelBuilder @

  builder: (name) ->
    @builders[name]

  attribute: (...args) ->
    @builder('attribute').build ...args

  model: (...args) ->
    @builder('model').build ...args

  collection: (...args) ->
    @builder('collection').build ...args

  pipe-type: 'Model'

  set-value: (obj) ->
    unless _.is-type 'Object', obj
      throw new Error "Value of model must be an object"
    key = _.keys(obj).first!
    value = obj
    value = obj[key] if key is @name
    @call-super value

  # TODO: It should perhaps figure out the ID from the Resource!
  id: ->
    return String(@object-id) unless @object-id is void
    # if no parent, I must assume i am just a named attribute model
    @name

  attributes: ->
    new AttributesPipe @

    #throw new Error "ModelPipe #{@name} unable to figure out its current id"

  pre-attach-to: (parent) ->
    @call-super!
    if parent.pipe-type is 'Collection'
      @object-id = parent.next-child-id!
      @_clazz = parent.name.singularize! if @_clazz is void

  valid-parents:
    * 'container'
    * 'collection'
)

module.exports = ModelPipe