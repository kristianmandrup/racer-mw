Class       = require('jsclass/src/core').Class

requires = require '../../requires'

ResourceCommand = requires.resource 'command'

Query = new Class(ResourceCommand,

  initialize: (@resource, @args) ->
    @call-super!
    @filter = @args.q

  commands:
    on-query:
      * 'ref'
      * 'get'
)