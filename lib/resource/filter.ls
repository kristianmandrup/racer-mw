Filter = new Class(ResourceCommand,

  initialize: (@resource, @filter) ->

  commands:
    * 'ref'
    * 'get'
)