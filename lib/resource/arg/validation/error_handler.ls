Class       = require('jsclass/src/core').Class
requires    = require '../../../../requires'

ErrorHandler = new Class(
  initialize: (@command-name, @command, @args) ->

  invalid-name: (name) ->
    console.log "Warning: Invalid argument #{name} for #{@command-name}, must be: #{@signature @command}"

  invalid-type: (name, value, valid-args) ->
    throw Error "Inavlid argument value #{value} for argument #{name}, calling #{@command-name}. Must be one of #{valid-args}"

  required: (name) ->
    throw Error "Missing required argument: #{name} from #{@args} calling #{@command-name}. Expected signature: #{@signature @command}"

  signature: (command) ->
    "Required: #{command.required}, Optional: #{command.optional}"

)

module.exports = ErrorHandler