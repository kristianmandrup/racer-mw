Class       = require('jsclass/src/core').Class

requires = require '../../requires'

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

PathResolver      = requires.pipe 'path_resolver'
BasePipe          = requires.pipe 'base'
ParentValidator   = requires.pipe 'validator/parent'

# TODO: refactor!?
ModelParentValidator = new Class(ParentValidator,
  valid-parent-types: ['collection', 'attribute']
)

# TODO: refactor!?
ModelChildValidator = new Class(ChildValidator,
  valid-child-types: ['attribute', 'path']
)


# Must be on a model or attribute
ModelPipe = new Class(BasePipe,
  initialize: (@parent, @obj) ->
    @validate!
    @call-super @obj

  validate: ->
    @parent-validator.validate!

  parent-validator: ->
    @_parent-validator ||= new ModelParentValidator @parent, @name

  child-validator: ->
    @_child-validator ||= new ModelChildValidator @child, @name

)

module.exports = ModelPipe