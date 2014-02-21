Query = new Class(
  initialize: (resource, query) ->
    # ...

  $ref: (path) ->
    @perform 'ref', path: path

  $get: ->
    @perform 'get'

)