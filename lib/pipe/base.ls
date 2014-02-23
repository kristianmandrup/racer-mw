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

      extend:
        $p: (hash) ->
          parent = @
          keys = _.keys(hash)
          throw Error "Must only have one key/value entry, was #{keys}"
          type = keys.first
          obj = hash['type']
          name = hash['name'] || obj.name
          @$pipe.children[name] = new PipeFactory(obj, parent: parent, type: type).create-pipe

        $pipe: (hash) ->
          keys = _.keys(hash)
          throw Error "Must only have one key/value entry, was #{keys}"
          type = keys.first
          new PipeFactory(hash[type], type: type).create-pipe

      # $type   : @type
      # $parent : @parent

      $children  : {}
      $prev   : (steps) ->
        walk '$parent', steps
      $root: ->
        walk '$parent', 9

      $detach: ->
        @$parent = void

      $attach: (pipe) ->
        @$parent = pipe

      $calc-path: ->
        new PathResolver(@value-object).full-path!
)

module.exports = Pipe
