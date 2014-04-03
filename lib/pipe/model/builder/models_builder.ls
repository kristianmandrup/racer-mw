Class   = require('jsclass/src/core').Class
get     = require '../../../requires' .get!
lo  = require 'lodash'
require 'sugar'

ModelPipe        = get.apipe 'model'
BasePipeBuilder  = get.base-builder 'base'

# Must be on a model or attribute
ModelsPipeBuilder = new Class(BasePipeBuilder,
  initialize: (@container) ->
    @call-super!
    @

  validate-container: ->
    @call-super!
    unless 'model' in @container.valid-children
      throw new Error "Parent Pipe #{@container.pipe-type} may not contain any Model pipe, only: #{@container.valid-children}"

  type: 'Builder'
  builder-type: 'Models'

  post-attach: (pipe) ->
    if pipe.clazz is void
      parent = pipe.parent
      if parent and parent.pipe-type is 'Collection'
        pipe.clazz = parent.name.singularize!

  create-pipe: (...args) ->
    @call-super!
    ModelPipe  = requires.apipe 'model'
    new ModelPipe ...args
)

module.exports = ModelsPipeBuilder