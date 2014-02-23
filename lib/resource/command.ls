Class       = require('jsclass/src/core').Class

requires = require '../../requires'

Filter  = requires.resource 'filter'
Query   = requires.resource 'query'

CommandBuilder = requires.resource 'command/builder'

ResourceCommand = new Class(
  initialize: ->
    new CommandBuilder(@).build!

  # we need to somehow inject the RacerStore
  racer-sync: ->
    @my-sync ||= new RacerSync

  get-path: ->
    @resource.pipe.get-path! # calculate or get cached ;)

  # args example:
  # ‘push’, object: value, cb: cb-fun
  perform: (action, hash) ->
    # save last executed command, just coz we can ;)
    @command = new RacerCommand(@resource).run(action).with hash
    @execute @command

  execute: (racer-command) ->
    @racer-sync.execute racer-command

  scoped: (command, hash) ->
    @scope = @perform command, hash
)

module.exports = ResourceCommand