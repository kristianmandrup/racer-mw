requires      = require '../../requires'
ArgumentError = requires.error!.named 'argument'

InvalidTypeError = (message) ->
  this.name = "InvalidTypeError"
  this.message = message or "InvalidTypeError"

InvalidTypeError.prototype = new ArgumentError
InvalidTypeError.prototype.constructor = InvalidTypeError

module.exports = InvalidTypeError