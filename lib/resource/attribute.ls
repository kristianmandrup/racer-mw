Class       = require('jsclass/src/core').Class

requires = require '../../requires'

requires.resource 'base'

BaseResource   = requires.resource 'base'

AttributeResource = new Class(BaseResource,
  initialize: (@pipe) ->
    @call-super!
    @

  resource-type: 'Attribute'

  commands:
    on-scope:
      * 'get'
      * 'ref'
      * 'remove-ref'
    set-scope:
      * 'set'
    set-number:
      * 'inc'
    set-string:
      * 'string-insert'
      * 'string-remove'
)

module.exports = AttributeResource