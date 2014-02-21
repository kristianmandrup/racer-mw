RessourceCommand = new Class(
  # get
    # no path = self
    # path = attribute
    model:

    # no path = self
    # path = item
    collection:

    # no path = self
    # path = sub-item
    attribute:

  # set, set-null, set-diff, del
    # path = attribute
    # no path = self
    model:

    # no path = self
    # path = item
    collection:

    # no path = self
    # path = sub-item
    attribute:

  # increment
    # path = attribute
    # % no path
    model:

    # %
    collection:

    # no path = self
    # path = sub-item
    attribute:

  # add
    # path = collection attribute
    # % no path
    model:

    # no path = self
    # % path
    collection:

    # %
    attribute:

  # all array commands:
    # requires path
    model:

    # no path = self
    collection:

    # %
    # always a simple!
    attribute:

  # string commands
    # requires path
    model:

    # only if string
    attribute:

    # %
    collection:

  at, scope
    # requires path
    model

    # requires id
    collection:

    # %
    attribute:

  parent:
    # ok if has parent pipe
    model, collection, attribute

  path:
    # ok
    model, collection

    # %
    attribute:

  ref:
    # to = full path (or pipe)

    # path must be id
    collection
    # path is attribute
    # no path = self
    model

    # no path, is self
    attribute:

  remove-ref:
    # path must be id
    collection
    # path is attribute
    # no path = self
    model

    # no path, is self
    attribute:

  ref-list:
    # path must be self, no arg
    collection

    # path is attribute which is collection
    # % no path
    model

    # %
    attribute:

  remove-ref-list:
    # collection is a pipe collection or a full path to a collection

    # path must be self, no arg
    collection

    # path is attribute which is collection
    # % no path
    model

    # %
    attribute:

)


  # length = model.push ( path, value, [callback] )
  # args is a hash> path: path, value: value

  # API usage examples: (which to allow?)
  # $pipe(collection: 'users').push(users)
  # $pipe(collection: 'users').$pipe(collection: '1.admins').push users)
  # $pipe(collection: 'users').push('1.admins', users)
  # $pipe(collection: 'users').$model(user: 1).push('admins', users)
  # $collection('users').$model(user: 1).push('admins', users)
  # $collection('users').$model(user: 1).$collection('admins').push users)

  $push: (args) ->
    @perform 'push', args

  # authorize container and value if Document
  # validate container and value if Document
  # marshal value (simple or Document)
  # length = model.unshift ( path, value, [callback] )
  # args is a hash> value: value, cb: cb
  $unshift: (args) ->
    @perform 'unshift', args

  # length = model.insert ( path, index, values, [callback] )

  # authorize container and value if Document
  # validate container and value if Document
  # marshal value (simple or Document)
  # args is a hash> index: index, values: values, cb: cb
  $insert: (args) ->
    @perform 'insert', args

  # item = model.pop ( path, [callback] )
  # path: Model path to an array
  # item: Removes the last item in the array and returns it
  # decorate popped value
  # should set popped (last item returned)

  # model.$pop('projects').popped
  # model.$pop('projects').push(new-project)

  # args is a hash> path: path, cb: cb
  $pop: (args) ->
    @perform 'pop', args

  # item = model.shift ( path, [callback] )
  # authorize container, Update
  # args is a hash> path: path, cb: cb
  $shift: (args) ->
    @perform 'shift', args

  # removed = model.remove ( path, index, [howMany], [callback] )
  # authorize container, Delete
  # should set removed (last item removed)

  # model.$remove('project').removed

  # should create removed hash (OrderedHash)
  # project = model.$remove('project').$remove('next-project').removed('project')

  # args is a hash> path: path, index: index, how-many: num, cb: cb
  remove: (args) ->
    @perform 'remove', args

  # moved = model.move ( path, from, to, [howMany], [callback] )
  # authorize container, Update
  # should set moved (last item removed)
  # args: path: path, from: from, to: to, [howMany: num], [cb: callback]
  move: (args) ->
    @perform 'move', args

  # args: path: path, collection: collectionPath, ids: idsPath, options: options
  $refList: (args) ->
    @scoped(@perform 'refList', args)
