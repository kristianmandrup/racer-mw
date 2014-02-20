Class       = require('jsclass/src/core').Class

require = require '../../requires'

requires.resource 'base'

CollectionResource = new Class(BaseResource,
  # value-object
  initialize: (@value-object)

  $push: (path) ->
    @perform 'push', path: path

  $refList: ( path, collectionPath, idsPath, options ) ->
    @scoped(@perform 'refList', path: path, collection: collectionPath, ids: idsPath, options: options)
)

module.exports = CollectionResource