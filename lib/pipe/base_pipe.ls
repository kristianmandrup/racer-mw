Class       = require('jsclass/src/core').Class

requires  = require '../../requires'

_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

ValueObject       = requires.lib 'value_object'
ParentValidator   = requires.pipe 'validator/parent'

# A Pipe can have one parent but many children. Pipes can thus be made into a tree.
# Each pipe reflect the type of object at that particular position in the model, thus
# it can act as a complete abstraction layer over the model.

# The constructor methods to attach a new pipe with this as the parent
# must depend on the types of valid child pipe
# we need some convenient container of this information
# same goes for parent (in case we detach and attach to a new parent!)

PipeBuilders  = requires.pipe 'builders'
PipeAttacher  = requires.pipe 'attacher'
PipeInspector = requires.pipe 'inspector'

argumentor    = requires.pipe 'argumentor'

BasePipe = new Class(
  include: [PipeBuilders, PipeAttacher, PipeInspector, PipeNavigator]

  # if not initialized with a value it has nothing to calculate path from
  initialize: ->
    [@first-arg, @args] = argumentor.extract arguments
    unless argumentor.validate @args, @valid-args
      throw new Error "Pipe init argument #{@args} [#{typeof @args}] is not valid, must be one of: #{@valid-args}"
    @

  type:       'Pipe'
  pipe-type:  'Base'
  children:   {}
  valid-args: []

  # subclass should override!
  valid-parents: []
  children  : {}
  parent: void

  # by default any pipe can have a resource (except PathPipe)
  has-resource: true

  post-build: ->

  validate-value: (value) ->
    true
  # override if necessary
  get-value: ->
    void

  set-value: (value) ->
    if @validate-value value
      @value = new ValueObject(value)

  # last step when pipe is initialized
  post-init: ->
    delete @args
    @$res = @create-res!
    @config-builders!
    @post-build!

  # to create and set resource of pipe
  create-res: ->
    return unless @has-resource
    @resource-clazz = requires.resource(@pipe-type.to-lower-case!)
    new @resource-clazz pipe: @

  set-name: (name) ->
    @name = name
    @update-name!

  id: ->
    throw new Error "A subclass of Pipe must implement id function"

  parent-validator: new ParentValidator(@valid-parents)

  child: (name) ->
    @children[name]

  parent-name: ->
    if @parent then @parent.full-name else ''

  update-name: ->
    names = [@parent-name!, @name].exclude (name) ->
      name is void or _.empty(name)

    @full-name = names.join '.'

  clear: ->
    children = {}
)

module.exports = BasePipe
