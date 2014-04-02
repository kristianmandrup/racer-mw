requires      = require '../../requires'
ArgumentError = requires.error!.named 'argument'

InvalidArgumentError = (message) ->
  this.name = "InvalidArgumentError"
  this.message = message or "InvalidArgumentError"

InvalidArgumentError.prototype = new ArgumentError
InvalidArgumentError.prototype.constructor = InvalidArgumentError

module.exports = InvalidArgumentError