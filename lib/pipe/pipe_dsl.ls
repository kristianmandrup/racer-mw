requires = require '../../requires'

CollectionPipe    = requires.apipe 'collection'
AttributePipe     = requires.apipe 'attribute'
ModelPipe         = requires.apipe 'model'
PathPipe          = requires.apipe 'path'

PipeDsl =
  path: (...args) ->
    new PathPipe ...args

  # alias for path
  container: (...args) ->
    @path ...args

  collection: (...args) ->
    new CollectionPipe ...args

  # creates a pipe for a model
  model: (...args) ->
    new ModelPipe ...args

module.exports = PipeDsl

