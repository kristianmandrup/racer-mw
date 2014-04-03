Class       = require('jsclass/src/core').Class

requires = require '../../requires'

ResourceCommand = requires.resource 'resource_command'

ResourceFilter = new Class(ResourceCommand,

  initialize: (@resource, @args) ->
    @call-super!
    @filter = @args.filter

  commands:
    on-filter:
      * 'ref'
      * 'get'
)

module.exports = ResourceFilter