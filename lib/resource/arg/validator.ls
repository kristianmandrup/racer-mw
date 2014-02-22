Class       = require('jsclass/src/core').Class

lo = require 'lodash'
_  = require 'prelude-ls'
require 'sugar'

requires = require '../../../requires'

ArgStore = requires.resource 'arg_store'

ArgValidator = new Class(
  initialize: (@resource, @command-name, @args) ->
    @command = @arg-store![@command]
    @arg-keys = _.keys @args

  error: ->
    @err-handler ||= @create-error-handler

  create-error-handler: ->
    ErrorHandler = requires.resource 'arg/error_handler'
    new ErrorHandler @command-name, @command, @args

  arg-store: ->
    @store ||= new ArgStore.all

  validate: ->
    validate-required!
    detect-invalid!
    validate-types!

  validate-types: ->
    get-type-validator!.validate!

  get-type-validator: ->
    new TypeValidator @args

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

  has-all-required-args: ->
    lo.intersection(@arg-keys, @command.required).length = @command.required
)

