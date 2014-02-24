Class       = require('jsclass/src/core').Class

requires = require '../../requires'

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

PathResolver      = requires.pipe 'path_resolver'
BasePipe          = requires.pipe 'base'


# Must be on a model or attribute
CollectionPipe = new Class(BasePipe,
  initialize: (@parent, @name) ->
    @validate!

    # TODO: allow for an object with _clazz, then simply use _clazz.pluralize and discard the object?
    unless typeof @name is 'string'
      throw new Error "CollectionPipe must have a String name argument, was: #{@name} [#{typeof @name}]"
    @call-super @name.pluralize!

  # attach a model pipe as a child
  model: (obj) ->
    unless typeof obj is 'object'
      throw new Error "Invalid Model pipe argument. Must be an object, was: #{obj}"

    model-pipe = new ModelPipe obj
    @.attach model-pipe

  valid-parents:
    * 'path'
)

module.exports = CollectionPipe