Class       = require('jsclass/src/core').Class
requires    = require '../../../../requires'

lo = require 'lodash'
_  = require 'prelude-ls'
require 'sugar'

ValidateArgs  = requires.lib 'validate_args'
ArgStore      = requires.resource 'arg/store'
ErrorHandler  = requires.resource 'arg/validation/error_handler'

Validator = new Class(
  include: ValidateArgs

  initialize: (@command-name, @args) ->
    unless @command-name
      throw new Error "Missing commandName argument"

    @command = @arg-store![@command-name]
    @validate-command!

    @validate-required command-name:  'string', @command-name, arguments
    @validate-required args:          'object', @args, arguments

    @arg-keys = _.keys @args

  error: ->
    @err-handler ||= @create-error-handler!

  create-error-handler: ->
    new ErrorHandler @command-name, @command, @args

  arg-store: ->
    @store ||= new ArgStore.repo

  validate: ->
    @validate-required!
    @detect-invalid!
    @validate-types!

  validate-types: ->
    @get-type-validator!.validate!

  get-type-validator: ->
    new TypeValidator @error, @args

  validate-required: ->
    @validate-command!
    @command.required.each (name) ->
      unless lo.contains @arg-keys, name
        @error!.required name

  detect-invalid: ->
    @arg-keys.each (name) ->
      unless matches('optional', name) or matches('required', name)
        @error!.invalid-name name

  validate-command: ->
    unless @command
      throw new Error "Unable to find command #{@command-name} in CommandStore"
      console.log @arg-store

  matches: (list, name) ->
    lo.contains @command[list], name

  has-all-required-args: ->
    lo.intersection(@arg-keys, @command.required).length = @command.required
)

module.exports = Validator

