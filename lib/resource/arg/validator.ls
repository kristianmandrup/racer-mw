Class       = require('jsclass/src/core').Class

lo = require 'lodash'
_  = require 'prelude-ls'

require = require '../../../requires'

# concatenates all of the arg hashes into one store
ArgsStore = new Class(
  initialize: ->
    @all = {}
    ['array', 'basic', 'query', 'reference', 'scoped', 'string'].each (command) ->
      lo.extend @all, requires.resource-arg command
)

ArgValidator = new Class(
  initialize: (@resource, @command, @args) ->
    @valid-args = @arg-store![@command]
    @arg-keys = _.keys @args

    @optional = [@valid-args.optional].compact!
    @required = [@valid-args.required].compact!

  arg-store: ->
    @store ||= new ArgStore.all

  validate: ->
    validate-required! and has-no-invalid-args!

  validate-required: ->
    @required.each (name) ->
      unless lo.contains @arg-keys, name
        throw Error "Required value for #{name} is missing in #{@args}"

  has-no-invalid-args: ->
    lo.intersection(@arg-keys, @optional).length > 0 or lo.intersection(@arg-keys, @required).length > 0
)

