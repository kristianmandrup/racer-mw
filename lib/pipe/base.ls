Class       = require('jsclass/src/core').Class

requires  = require '../../requires'

_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

# calling 'meth' on 'obj' repeatedly for 'steps' steps or untill undefined is reached
walk = (meth, steps) ->
  inner-walk = (obj, steps) ->
    return obj if steps is 0
    return obj if obj is void
    next = obj[meth]!
    if next isnt void then inner-walk(next, --steps) else obj
  if steps > 10
    throw Error "You should NEVER have more than 10 pipes in a model pipeline!!!"
  inner-walk @, steps

ValueObject       = requires.lib 'value_object'
ParentValidator   = requires.pipe 'validator/parent'

# A Pipe can have one parent but many children. Pipes can thus be made into a tree.
# Each pipe reflect the type of object at that particular position in the model, thus
# it can act as a complete abstraction layer over the model.

# The constructor methods to attach a new pipe with this as the parent
# must depend on the types of valid child pipe
# we need some convenient container of this information
# same goes for parent (in case we detach and attach to a new parent!)

CollectionPipeBuilder = requires.pipe-builder 'collection'
ModelPipeBuilder      = requires.pipe-builder 'model'
AttributePipeBuilder  = requires.pipe-builder 'attribute'

BasePipe = new Class(
  # if not initialized with a value it has nothing to calculate path from
  initialize: ->
    @type = 'Pipe'
    @args = _.values arguments
    @args = [@args].flatten!
    @args = @args.first! if @args.length is 1
    @children = {}

    unless @args
      throw new Error "Pipe must take a value to help it determine a path in the model"

    unless @validate-args
      throw new Error "Pipe init argument #{@args} [#{typeof @args}] is not valid, must be one of: #{@valid-args}"
    @

  config-builders: ->
    @builders = {}
    @builders['collection']   = new CollectionPipeBuilder @
    @builders['model']        = new ModelPipeBuilder @
    @builders['attribute']    = new AttributePipeBuilder @

  builder: (name) ->
    @builders[name]

  set-value: (value) ->
    if @validate-value value
      @value = new ValueObject(value)

  validate-value: (value) ->
    true

  child-types: ->
    return "no children" unless @child-names!.length > 0
    self = @
    @child-names!.map (name) ->
      self.child(name).pipe-type

  describe-children: ->
    return "no children" unless @child-names!.length > 0
    self = @
    @child-names!.map (name) ->
      self.child(name).describe-self!

  describe-self: ->
    type: @pipe-type
    name: @name
    id: @id!
    value: @value

  post-init: ->
    delete @args
    @$res = @create-res!
    @config-builders!
    @post-build!

  post-build: ->

  pipe-type: 'Base'

  create-res: ->
    return unless @has-resource
    @resource-clazz = requires.resource(@pipe-type.to-lower-case!)
    new @resource-clazz pipe: @

  get-value: ->
    void

  set-name: (name) ->
    @name = name
    @update-name!

  validate-args: ->
    return true if @valid-args.length is 0
    valid-args = @args.select (arg) ->
      typeof(arg) in @valid-args
    valid-args.length is args.length

  valid-args: []

  # by default any pipe can have a resource
  has-resource: true

  id: ->
    throw new Error "A subclass of Pipe must implement id function"

  parent-validator: new ParentValidator(@valid-parents)

  # subclass should override!
  valid-parents: []

  children  : {}

  child-names: ->
    _.keys @children

  child: (name) ->
    @children[name]

  prev   : (steps) ->
    walk.call @, 'parent', steps

  root: ->
    walk.call @, 'parent', 9

  parent: void

  detach: ->
    @parent = void
    @_attached-to!
    @

  # when attached, a pipe should update its cached full-name
  attach: (pipe) ->
    pipe.attach-to @

  parent-name: ->
    if @parent then @parent.full-name else ''

  update-name: ->
    names = [@parent-name!, @name].exclude (name) ->
      name is void or _.empty(name)

    @full-name = names.join '.'

  attach-to: (parent) ->
    @parent-validator.validate parent, @

    # @id = parent.children.length
    unless @id!
      throw new Error "id function of #{@pipe-type} Pipe returns invalid id: #{@id!}"

    @pre-attach-to parent

    parent.children[@id!] = @
    @parent = parent
    @_attached-to parent

    @post-attach-to parent
    @

  clear: ->
    children = {}

  # throw new Error if invalid pipe for parent
  validate-attch: (parent) ->

  post-attach-to: (parent) ->

  pre-attach-to: (parent) ->
    @validate-attch parent

  _attached-to: (parent) ->
    @parent = parent
    # update full-name
    @update-name!
    # and each of its children also need to be updated!
    for k, v of @children
      @children[k].update-name!
    if parent
      parent.added = @
    @
)

module.exports = BasePipe
