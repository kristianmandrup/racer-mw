Class       = require('jsclass/src/core').Class

require = require '../../requires'

requires.resource 'base'

# $model(user).$att('age').inc 4
# $model(user).$att('age').set 4
# $model(user).set other-user

ModelResource = new Class(BaseResource,
  # value-object
  initialize: (args)

  commands:
    on-scope:
      * 'get'
      * 'set'
      * 'set-null'
      * 'set-diff'
      * 'del'
      * 'ref'
      * 'remove-ref'
)

module.exports = ModelResource