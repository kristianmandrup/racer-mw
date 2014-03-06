Class       = require('jsclass/src/core').Class

requires = require '../../requires'

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

BasePipe          = requires.pipe 'base'
AttributePipe     = requires.pipe 'attribute'
CollectionPipe    = requires.pipe 'collection'
AttributesPipe    = requires.pipe 'attributes'

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
    @

  pipe-type: 'Model'

  set-value: (obj) ->
    unless _.is-type 'Object', obj
      throw new Error "Value of model must be an object"
    key = _.keys(obj).first!
    value = obj
    value = obj[key] if key is @name
    @value = value

  # TODO: It should perhaps figure out the ID from the Resource!
  id: ->
    return String(@object-id) unless @object-id is void
    # if no parent, I must assume i am just a named attribute model
    @name

  attributes: ->
    new AttributesPipe @

    #throw new Error "ModelPipe #{@name} unable to figure out its current id"

  # TODO: Major refactoring needed. Split out in separate modules or classes
  collection: ->
    args = _.values(arguments)
    switch args.length
    case 0
      throw new Error "Must take at least one argument to indicate the collection to add"
    case 1
     collection = new CollectionPipe args.first!
     @attach collection
     collection
    default
      throw new Error "Too many arguments, takes only a name (String), or an Object"

  model: ->
    args = _.values(arguments)
    switch args.length
    case 0
      throw new Error "Must take a name, a value (object) or a {name: value} as an argument"
    case 1
     @_add-model args.first!
    default
      throw new Error "Too many arguments, takes only a name, a value (object) or a {name: value}"

  _add-model: (arg) ->
    switch typeof! arg
    case 'String'
      @_name-model arg
    case 'Object'
      @_hash-model arg
    default
      throw new Error "Invalid Attribute pipe argument. Must a name (string) or an object (hash), was: #{arg}"

  _name-model: (name) ->
    @attribute name

  _hash-model: (hash) ->
    key = _.keys(hash).first!
    value = _.values(hash).first!
    switch key
    case 'collection'
      throw new Error "No such thing as a Collection model. Try adding a collection directly instead, f.ex: .collection('users')"
    case 'model'
      # just ignore the model key and go with the value ;)
      @model value
    default
      #.model(administers: project)
      # should turn into:
      #.attribute('administers').model(project)

      # reuse existing attribute functionaility :)
      @attribute hash

  # attach an attribute pipe as a child
  attribute: ->
    args = _.values(arguments)
    switch arguments.length
    case 0
      throw new Error "Must take a name or a {name: value} as an argument"
    case 1
      @_add-attribute args.first!
    default
      throw new Error "Too many arguments, takes only a name (string) or an object (hash)"


  _add-attribute: (arg) ->
    switch typeof! arg
    case 'String'
      @_name-attribute arg
    case 'Object'
      @_hash-attribute arg
    default
      throw new Error "Invalid Attribute pipe argument. Must be a name (string) or an object (hash), was: #{arg}"

  _name-attribute: (name) ->
    pipe = new AttributePipe name
    @attach pipe
    pipe

  _hash-attribute: (hash) ->
    key = _.keys(hash).first!
    value = _.values(hash).first!
    switch key
    case 'collection'
      # since attribute should only be for simple types, String, Int etc.
      collection = new CollectionPipe(value)
      @attach collection
      collection
    case 'model'
      # since attribute should only be for simple types, String, Int etc.
      model = new ModelPipe(_clazz: value)
      @attach model
      model
    default
      # what should really happen here?
      # .model(administers: project)
      # should turn into:
      # .attribute('administers').model(project)
      pipe = @_pipe-from(key, value)
      @attach pipe
      pipe

  _pipe-from: (key, value) ->
    if _.is-type 'Object', value
      return new ModelPipe "#{key}": value
    if _.is-type 'Array', value
      return new CollectionPipe "#{key}": value

    return new AttributePipe "#{key}": value

  pre-attach-to: (parent) ->
    if parent.pipe-type is 'Collection'
      @object-id = parent.next-child-id!
      @_clazz = parent.name.singularize! if @_clazz is void

  valid-parents:
    * 'container'
    * 'collection'
)

module.exports = ModelPipe