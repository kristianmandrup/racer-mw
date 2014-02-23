PipeDsl =
  path: (path) ->
    @parent.attach new PathPipe(@parent, path)

  collection: (name) ->
    @parent.attach new CollectionPipe(@parent, name)

  # creates a pipe for a model
  model: (obj) ->
    @parent.attach new ModelPipe(@parent, obj)

  # creates a pipe for a model
  attribute: (name) ->
    @parent.attach new AttributePipe(@parent, name)

  p: (hash) ->
    parent = @
    keys = _.keys(hash)
    unless keys.length is 1
      throw Error "Must only have one key/value entry, was #{keys}"

    [name, type, obj] = @unpack keys, hash

    # use attach instead!
    @pipe.children[name] = create-child-pipe(obj, parent, type)

  unpack: (keys, hash) ->
    type = keys.first
    obj = hash['type']
    name = hash['name'] || obj.name
    [name, type, obj]


  pipe: (hash) ->
    keys = _.keys(hash)
    throw Error "Must only have one key/value entry, was #{keys}"
    type = keys.first
    create-pipe hash, type

  create-child-pipe: (obj, parent, type) ->
    new PipeFactory(obj, parent: parent, type: type).create-pipe!

  create-pipe: (hash, type) ->
    new PipeFactory(hash[type], type: type).create-pipe!

