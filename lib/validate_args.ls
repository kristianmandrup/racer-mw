Class         = require('jsclass/src/core').Class
requires      = require '../requires'

lo            = require 'lodash'
_             = require 'prelude-ls'
require 'sugar'

errors            = requires.lib 'errors'
ArgumentError     = errors.ArgumentError
InvalidTypeError  = errors.InvalidTypeError

ValidateArgs = new Class(
  validate-required: (hash, arg-value, args) ->
    [name, type] = @unpack hash
    @validate-missing "#{name}": arg-value, args
    @validate-type "#{name}": type, arg-value if type

  validate-missing: (hash, args) ->
    [name, arg-value] = @unpack hash
    @missing(name, args) unless arg-value

  validate-type: (hash, arg-value) ->
    [name, types] = @unpack hash
    types = [types].flatten!
    @type-error(name, types) unless types.any (type) -> typeof arg-value is type

  missing: (name, args) ->
    throw new ArgumentError "Missing #{name} argument in: #{args}"

  type-error: (hash, arg-value) ->
    [name, types] = @unpack hash
    value = arg-value
    type = String(typeof(value)).capitalize!
    throw new InvalidTypeError "#{name} argument must be #{@type-msg types}, was: #{value} [#{type}]"

  type-msg: (...types) ->
    types = [...types].flatten!
    switch types.length
    case 1
      "a #{types}"
    default
      "one of: #{types}"

  unpack: (hash) ->
    name = hash
    type = void
    if typeof hash is 'object'
      lo.for-own hash, (value, key) ->
        name := key
        type := value
    [name, type]
)

module.exports = ValidateArgs