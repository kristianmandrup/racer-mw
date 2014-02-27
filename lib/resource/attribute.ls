Class       = require('jsclass/src/core').Class

requires = require '../../requires'

requires.resource 'base'

BaseResource   = requires.resource 'base'

AttributeResource = new Class(BaseResource,
  initialize: (@pipe) ->
    @call-super!

  resource-type: 'Attribute'

  commands:
    scope:
      * 'get'
      * 'set'
      * 'ref'
      * 'remove-ref'
    number:
      * 'inc'
    string:
      * 'string-insert'
      * 'string-remove'
)

module.exports = AttributeResource