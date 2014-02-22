requires      = require '../../requires'
ArgumentError = requires.error 'argument_error'

RequiredArgumentError = (message) ->
  this.name = "RequiredArgumentError"
  this.message = message or "RequiredArgumentError"

RequiredArgumentError.prototype = new ArgumentError
RequiredArgumentError.prototype.constructor = RequiredArgumentError

module.exports = RequiredArgumentError