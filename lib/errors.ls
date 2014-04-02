requires      = require '../requires'

ArgumentError = requires.error!.named 'argument'

module.exports =
  ArgumentError         : ArgumentError
  InvalidArgumentError  : requires.error!.named 'invalid_argument'
  InvalidTypeError      : requires.error!.named 'invalid_type'
  RequiredArgumentError : requires.error!.named 'required_argument'