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
  initialize: (@resource, @command-name, @args) ->
    @command = @arg-store![@command]
    @arg-keys = _.keys @args

  error: ->
    @err-handler ||= @create-error-handler

  create-error-handler: ->
    ErrorHandler = requires.resource 'arg/error_handler'
    new ErrorHandler @command-name, @command, @args

  types-map: ->
    @types ||= requires.resource 'type_map'

  arg-store: ->
    @store ||= new ArgStore.all

  validate: ->
    validate-required!
    detect-invalid!
    validate-types!

  validate-types: ->
    lo.for-own @args, (key, value) ->
      validate-type key, value

  validate-type: (key, value) ->
    unless is-valid key, value
      @error.invalid-type key, value, valid-types

  is-valid: (key, value) ->
    valid-types-for(key).any (valid-type) ->
      typeof value is valid-type

  valid-types-for: (key) ->
    [types-map![key]].flatten

  validate-required: ->
    @command.required.each (name) ->
      unless lo.contains @arg-keys, name
        @error!.required name

  detect-invalid: ->
    @arg-keys.each (name) ->
      unless matches('optional', name) or matches('required', name)
        @error!.invalid-name name

  matches: (list, name) ->
    lo.contains @command[list], name

  has-no-invalid-args: ->
    lo.intersection(@arg-keys, @command.optional).length > 0 or lo.intersection(@arg-keys, @command.required).length > 0
)

