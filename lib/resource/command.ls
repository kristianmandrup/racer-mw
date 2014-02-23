Class       = require('jsclass/src/core').Class

requires = require '../../requires'

Filter  = requires.resource 'filter'
Query   = requires.resource 'query'

CommandBuilder = requires.resource 'command/builder'

ResourceCommand = new Class(
  initialize: (@resource) ->
    new CommandBuilder(@).build!

  sync: ->
    @my-sync ||= new RacerSync @

  get-path: ->
    @resource.get-path! # calculate or get cached ;)

  perform: (action, hash) ->
    @sync.perform action, @get-path!, hash
    @

  scoped: (command, hash) ->
    @scope = @perform command, hash

  commands:
    create:
      * 'query'   # new Query   @resource, @query
      * 'filter'  # new Filter  @resource, @filter
)

module.exports = ResourceCommand