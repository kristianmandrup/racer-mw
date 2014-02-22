ArgumentError = (message) ->
  this.name = "ArgumentError"
  this.message = message or "ArgumentError"

ArgumentError.prototype = new Error
ArgumentError.prototype.constructor = ArgumentError

module.exports = ArgumentError