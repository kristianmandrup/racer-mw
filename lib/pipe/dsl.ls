PipeDsl =
  path: (path) ->
    @parent.attach new PathPipe(@parent, path)

  # alias for path
  container: (path) ->
    @path(path)

  collection: (name) ->
    @parent.attach new CollectionPipe(@parent, name)

  # creates a pipe for a model
  model: (obj) ->
    @parent.attach new ModelPipe(@parent, obj)

  # creates a pipe for a model
  attribute: (name) ->
    @parent.attach new AttributePipe(@parent, name)



