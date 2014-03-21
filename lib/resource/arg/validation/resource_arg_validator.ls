Class       = require('jsclass/src/core').Class
requires    = require '../../../../requires'

lo = require 'lodash'
_  = require 'prelude-ls'
require 'sugar'

ValidateArgs  = requires.lib 'validate_args'
ArgStore      = requires.resource 'arg/resource_arg_store'
ErrorHandler  = requires.resource 'arg/validation/resource_arg_error_handler'
TypeValidator = requires.resource 'arg/validation/resource_arg_type_validator'

Validator = new Class(
  initialize: (@command-name, @args) ->
    unless @command-name
      throw new Error "Missing commandName argument"

    @command = @arg-store!.repo[@command-name]
    @validate-command!

    unless typeof @args is 'object'
      throw new Error "Invalid argument type for args, must be Object, was: #{typeof @args}"
    @arg-keys = _.keys @args

    @arg-validator!.validate-required command-name:  'string', @command-name, arguments
    @arg-validator!.validate-required args:          'object', @args, arguments
    @

  arg-validator: ->
    @arg-v ||= new ValidateArgs

  error: ->
    @err-handler ||= @create-error-handler!

  create-error-handler: ->
    new ErrorHandler @command-name, @command, @args

  arg-store: ->
    @store ||= new ArgStore

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
    return unless @command.required
    self = @
    required = [@command.required].flatten!
    required.each (name) ->
      self.validate-required-key name

  validate-required-key: (name) ->
    self = @
    unless lo.contains @arg-keys, name
      self.error!.required name

  detect-invalid: ->
    self = @
    @arg-keys.each (name) ->
      unless self.matches('optional', name) or self.matches('required', name)
        self.error!.invalid-name name
    false

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

