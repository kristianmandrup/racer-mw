Class       = require('jsclass/src/core').Class

require = require '../../requires'

requires.resource 'base'

AttributeResource = new Class(BaseResource,
  # value-object
  initialize: (@value-object)

  self-commands:
    * 'get'
    * 'set'
    * 'ref'
    * 'remove-ref'

  number-commands:
    * 'inc'

  string-commands:
    * 'string-insert'
    * 'string-remove'
)

module.exports = AttributeResource