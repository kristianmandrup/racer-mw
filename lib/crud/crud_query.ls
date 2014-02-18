Class       = require('jsclass/src/core').Class
Module      = require('jsclass/src/core').Module
Hash        = require('jsclass/src/core').Hash

requires    = require '../../requires'
lo          = require 'lodash'
_           = require 'prelude-ls'

RacerSync   = requires.crud 'racer_sync'

Query = new Class(RacerSync,
  extend:
    create: (collection, ids) ->
      new @ collection: collection

  # validation not needed
  # must decorate loaded model
  mw-stack: ->
    @create-stack 'authorize-mw'

  decorate-stack: ->
    @create-stack 'decorator-mw'

  # query = model.query ( collectionName, [databaseQuery or path] )
  # authorize on collection
  find: (query) ->
    @res = @perform 'query', @doc-path, query

  # decorate results
  get: (query) ->
    @query query if query
    @results ||= decorate @res.get!

  decorate: (docs) ->
    docs.map (doc) ->
      decorate-stack.run data: doc

  # path: Local path at which to create an updating refList of the queries results
  # how/where to decorate results from live update?
  # authorize on collection/path ?
  get-live-update (path, query) ->
    @query query if query
    @res.ref path

  clear: ->
    @results = void
)

module.exports = Query