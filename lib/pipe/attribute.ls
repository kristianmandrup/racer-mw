Class       = require('jsclass/src/core').Class

requires = require '../../requires'

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

PathResolver      = requires.pipe 'path_resolver'
BasePipe          = requires.pipe 'base'
ParentValidator   = requires.pipe 'validator/parent'

# TODO: refactor!?
AttributeParentValidator = new Class(ParentValidator,
  valid-parent-types: ['model', 'attribute']
)

# TODO: refactor!?
AttributeChildValidator = new Class(ChildValidator,
  valid-child-types: []
)

# Must be on a model
AttributePipe = new Class(BasePipe,
  initialize: (@parent, @name) ->
    @validate!
    @call-super @name

  validate: ->
    @parent-validator.validate!

  parent-validator: ->
    @_parent-validator ||= new AttributeParentValidator @parent, @name

  child-validator: ->
    @_child-validator ||= new AttributeChildValidator @child, @name

)

module.exports = AttributePipe