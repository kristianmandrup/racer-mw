Class       = require('jsclass/src/core').Class

requires = require '../../requires'

Filter  = requires.resource 'filter'
Query   = requires.resource 'query'

CommandBuilder = requires.resource 'command/builder'

ResourceCommand = new Class(
  initialize: ->
    new CommandBuilder(@).build!

  sync: ->
    @my-sync ||= new RacerSync @

  get-path: ->
    @resource.pipe.get-path! # calculate or get cached ;)

  perform: (action, hash) ->
    @sync.perform action, @get-path!, hash
    @

  scoped: (command, hash) ->
    @scope = @perform command, hash
)

module.exports = ResourceCommand