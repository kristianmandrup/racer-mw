Class         = require('jsclass/src/core').Class
requires      = require '../../../../requires'

ValidateArgs  = requires.lib 'validate_args'
errors        = requires.lib 'errors'

RequiredArgumentError = errors.RequiredArgumentError
InvalidTypeError      = errors.InvalidTypeError

ErrorHandler = new Class(
  include: ValidateArgs

  initialize: (@command-name, @command, @args) ->
    @validate-required command-name:  'string', @command-name, arguments
    @validate-required command:       'object', @command, arguments
    @validate-required args:          'object', @args, arguments

  invalid-name: (name) ->
    console.log "Warning: Invalid (unknown) argument #{name} for #{@command-name}, must be: #{@signature @command}"

  invalid-type: (name, value, valid-types) ->
    throw new InvalidTypeError "Invalid argument value #{value} for argument #{name}, calling #{@command-name}. Must be one of #{valid-types}"

  required: (name) ->
    throw new RequiredArgumentError "Missing required argument: #{name} from #{@args} calling #{@command-name}. Expected signature: #{@signature @command}"

  signature: (command) ->
    "Required: #{command.required}, Optional: #{command.optional}"

)

module.exports = ErrorHandler