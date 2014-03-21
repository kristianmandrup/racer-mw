Class       = require('jsclass/src/core').Class

requires = require '../../requires'

ResourceCommand = requires.resource 'resource_command'

ResourceQuery = new Class(ResourceCommand,

  initialize: (@resource, @args) ->
    @call-super!
    @filter = @args.q

  commands:
    on-query:
      * 'ref'
      * 'get'
)

module.exports = ResourceQuery