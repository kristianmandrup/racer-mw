Class       = require('jsclass/src/core').Class

requires = require '../../requires'

Filter  = requires.resource 'resource_filter'
Query   = requires.resource 'resource_query'

CommandBuilder = requires.resource 'command/resource_command_builder'
RacerCommand   = requires.racer    'racer_command'
RacerSync      = requires.racer    'racer_sync'

ResourceCommand = new Class(
  initialize: (@resource) ->
    # add commands to resource
    new CommandBuilder(@).build!
    if @pipe
      # and to pipe of resource with $ prefix
      new CommandBuilder(@pipe, '$').build!

  # inject the RacerStore
  racer-sync: (command) ->
    @my-sync ||= new RacerSync command

  get-path: ->
    @resource.pipe.get-path! # calculate or get cached ;)

  # args example:
  # ‘push’, object: value, cb: cb-fun
  perform: (action, hash) ->
    # save last executed command, just coz we can ;)
    @command = new RacerCommand(@resource).run(action).using hash
    @execute @command

  execute: (racer-command) ->
    unless racer-command
      throw new Error "No RacerCommand to execute, was: #{racer-command}"

    @racer-sync(racer-command).execute!

  scoped: (command, hash) ->
    @scope = @perform command, hash
)

module.exports = ResourceCommand