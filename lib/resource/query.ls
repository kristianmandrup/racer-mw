Query = new Class(ResourceCommand,

  initialize: (@resource, @query) ->

  commands:
    on-query:
      * 'ref'
      * 'get'
)