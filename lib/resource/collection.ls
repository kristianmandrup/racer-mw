Class       = require('jsclass/src/core').Class

require = require '../../requires'

requires.resource 'base'

# @perform should always Validate incoming Hash arguments according to context
CollectionResource = new Class(BaseResource,
  # value-object
  initialize: (@value-object)

  # length = model.push ( path, value, [callback] )
  # args is a hash> path: path, value: value
  
  # API usage examples: (which to allow?)
  # $pipe(collection: 'users').push(users)
  # $pipe(collection: 'users').$pipe(collection: '1.admins').push users)
  # $pipe(collection: 'users').push('1.admins', users)    
  # $pipe(collection: 'users').model(user: 1).push('admins', users)
  
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
  
  # model.$pop('project').popped
  # model.$pop('project').push(new-project)
  
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
)

module.exports = CollectionResource
