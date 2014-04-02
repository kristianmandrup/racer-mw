requires      = require '../../requires'
ArgumentError = requires.error!.named 'argument'

RequiredArgumentError = (message) ->
  this.name = "RequiredArgumentError"
  this.message = message or "RequiredArgumentError"

RequiredArgumentError.prototype = new ArgumentError
RequiredArgumentError.prototype.constructor = RequiredArgumentError

module.exports = RequiredArgumentError