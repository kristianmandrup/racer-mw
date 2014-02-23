Class       = require('jsclass/src/core').Class

requires = require '../../requires'

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

PathResolver      = requires.pipe 'path_resolver'
BasePipe          = requires.pipe 'base'
ParentValidator   = requires.pipe 'validator/parent'

AttributeParentValidator = new Class(ParentValidator,
  valid-parent-types: ['model', 'attribute']
)

# Must be on a model
AttributePipe = new Class(BasePipe,
  initialize: (@parent, @name) ->
    @validate!

  validate: ->
    @parent-validator.validate!

  parent-validator: ->
    @_parent-validator ||= new AttributeParentValidator @parent, @name
)