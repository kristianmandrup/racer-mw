Class       = require('jsclass/src/core').Class

requires = require '../../requires'

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

PathResolver = requires.pipe 'path_resolver'

walk = (meth, steps) ->
  if steps > 10
    throw Error "You should NEVER have more than 10 pipes in a model pipeline!!!"
  step = 0
  location = @[meth]!
  while step < steps and locations isnt void
    location = location[meth]!
  location

validate-args = (args) ->
  validate-arg-types.any (valid-type) ->
    typeof args is valid-type

validate-arg-types =
  * 'string'
  * 'object'
  * 'function'
  * 'array'

# A Pipe can have one parent but many children. Pipes can thus be made into a tree.
# Each pipe reflect the type of object at that particular position in the model, thus
# it can act as a complete abstraction layer over the model.

# The constructor methods to attach a new pipe with this as the parent
# must depend on the types of valid child pipe
# we need some convenient container of this information
# same goes for parent (in case we detach and attach to a new parent!)

Pipe = new Class(
      # if not initialized with a value it has nothing to calculate path from
      initialize: (...args) ->
        args = [args].flatten!
        args = args.first! if args.length is 1
        unless args
          throw new Error "Pipe must take a value to help it determine a path in the model"
        unless validate-args args
          # TODO: if number, check if parent is collection
          throw new Error "Pipe init argument #{args} [#{typeof args}] is not valid, must be one of: #{validate-arg-types}"

      children  : {}
      prev   : (steps) ->
        walk 'parent', steps
      root: ->
        walk 'parent', 9

      detach: ->
        @parent = void

      attach: (pipe) ->
        # TODO: must call parent validator!
        @parent-validator(@parent, ).validate
        @parent = pipe

      calc-path: ->
        new PathResolver(@value-object).full-path!
)

module.exports = Pipe
