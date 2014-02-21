Class       = require('jsclass/src/core').Class

require = require '../../requires'

requires.resource 'base'

# @perform should always Validate incoming Hash arguments according to context
CollectionResource = new Class(BaseResource,
  # value-object
  initialize: (@value-object)

  commands:
    * 'get'
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
    * 'db-query'


)

module.exports = CollectionResource
