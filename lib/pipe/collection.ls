Class       = require('jsclass/src/core').Class

requires = require '../../requires'

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

PathResolver      = requires.pipe 'path_resolver'
BasePipe          = requires.pipe 'base'
ParentValidator   = requires.pipe 'validator/parent'

CollectionParentValidator = new Class(ParentValidator,
  valid-parent-types: ['path']
)

CollectionChildValidator = new Class(ChildValidator,
  valid-child-types: ['model']
)


# Must be on a model or attribute
CollectionPipe = new Class(BasePipe,
  initialize: (@parent, @name) ->
    @validate!

    # TODO: allow for an object with _clazz, then simply use _clazz.pluralize and discard the object?
    unless typeof @name is 'string'
      throw new Error "CollectionPipe must have a String name argument, was: #{@name} [#{typeof @name}]"
    @call-super @name.pluralize!

  validate: ->
    @parent-validator.validate!

  parent-validator: ->
    @_parent-validator ||= new ModelParentValidator @parent, @name
)

module.exports = CollectionPipe