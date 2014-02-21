
Filter  = requires.resource 'filter'
Query   = requires.resource 'query'

ResourceCommand = new Class(
  initialize: (@resource)

  sync: ->
    @my-sync ||= new RacerSync @

  get-path: ->
    @resource.get-path! # calculate or get cached ;)

  perform: (action, hash) ->
    @sync.perform action, @get-path!, hash
    @

  scoped: (command, hash) ->
    @scope = @perform command, hash

  on-values:
    * 'scope' # looks for on-scope
    * 'query'
    * 'filter'

  create:
    query:  Query   # new Query   @resource, @query
    filter: Filter  # new Filter  @resource, @filter
)