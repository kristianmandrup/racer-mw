ArgumentError = (message) ->
  this.name = "ArgumentError"
  this.message = message or "ArgumentError"

ArgumentError.prototype = Error.prototype
ArgumentError.prototype.constructor = ArgumentError

module.exports = ArgumentError