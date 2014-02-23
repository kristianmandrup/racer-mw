Class       = require('jsclass/src/core').Class

requires = require '../../requires'

requires.resource 'base'

# @perform should always Validate incoming Hash arguments according to context
CollectionResource = new Class(BaseResource,
  # value-object
  initialize: (args)

  commands:
    on-scope: # always on scope
      * 'get'
    set-scope:
      * 'set'
      * 'set-null'
      * 'set-diff'
      * 'del'
      * 'add'
      * 'push'
      * 'unshift'
      * 'insert'
      * 'pop'
      * 'shift'
      * 'remove'
      * 'move'
      * 'ref-list'
      * 'remove-ref-list'
    query:
      * 'query'
    filter:
      * 'filter'
      * 'sort'
)

module.exports = CollectionResource
