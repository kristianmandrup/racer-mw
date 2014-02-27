Class       = require('jsclass/src/core').Class

requires  = require '../../requires'

_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

PathResolver = requires.pipe 'path_resolver'

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


ParentValidator   = requires.pipe 'validator/parent'

# A Pipe can have one parent but many children. Pipes can thus be made into a tree.
# Each pipe reflect the type of object at that particular position in the model, thus
# it can act as a complete abstraction layer over the model.

# The constructor methods to attach a new pipe with this as the parent
# must depend on the types of valid child pipe
# we need some convenient container of this information
# same goes for parent (in case we detach and attach to a new parent!)

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

  validate-args: ->
    return true if @valid-args.length is 0
    valid-args = @args.select (arg) ->
      typeof(arg) in @valid-args
    valid-args.length is args.length

  valid-args: []

  id: ->
    throw new Error "Any subclass of Pipe must implement id function"

  parent-validator: new ParentValidator(@valid-parents)

  # subclass should override!
  valid-parents: []

  children  : {}

  child: (name) ->
    @children[name]

  prev   : (steps) ->
    walk.call @, 'parent', steps
  root: ->
    walk.call @, 'parent', 9

  parent: void

  detach: ->
    @parent = void

  attach: (pipe) ->
    unless typeof(pipe) is 'object' and pipe.type is 'Pipe'
      throw new Error "Only other pipes can be attached to a pipe, was: #{util.inspect pipe} [#{typeof pipe}]"

    @parent-validator.validate @, pipe

    unless pipe.id!
      throw new Error "id function of #{pipe.name} #{pipe.pipe-type} Pipe returns invalid id: #{pipe.id!} #{util.inspect pipe}"

    @children[pipe.id!] = pipe
    pipe.parent = @

    if @pipe-type is 'Collection'
      pipe.id = @children.length

  attach-to: (parent) ->
    @parent-validator.validate parent, @

    # @id = parent.children.length
    unless @id!
      throw new Error "id function of #{@pipe-type} Pipe returns invalid id: #{@id!}"

    parent.children[@id!] = @
    @parent = parent

  calc-path: ->
    new PathResolver(@).full-path!
)

module.exports = BasePipe
