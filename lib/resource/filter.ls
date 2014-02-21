Filter = new Class(ResourceCommand,

  initialize: (@resource, @filter) ->

  commands:
    on-filter:
      * 'ref'
      * 'get'
)