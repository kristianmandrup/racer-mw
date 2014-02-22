requires      = require '../requires'

ArgumentError = requires.error 'argument_error'

module.exports =
  ArgumentError         : ArgumentError
  InvalidArgumentError  : requires.error 'invalid_argument_error'
  InvalidTypeError      : requires.error 'invalid_type_error'
  RequiredArgumentError : requires.error 'required_argument_error'