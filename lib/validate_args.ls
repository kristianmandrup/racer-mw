Module        = require('jsclass/src/core').Module
requires      = require '../requires'

errors        = requires.lib 'errors'
ArgumentError = errors.ArgumentError

ValidateArgs = new Module(

  validate-required: (hash, arg-value, args) ->
    name = hash
    type = void
    if hash typeof 'object'
      _.for-own hash, (key, value) ->
        name := key
        type := value

    @validate-missing name, arg-value, args
    @validate-type-error name, type, arg-value if type

  validate-missing: (name, arg-value, args) ->
    @missing(name, args) unless arg-value

  validate-type-error: (name, type, arg-value) ->
    @type-error(name, type) unless arg-value typeof type

  missing: (name, args) ->
    throw new ArgumentError "Missing #{name} argument in: #{args}"

  type-error: (name, type, arg-value) ->
    throw new TypeError "#{name} argument must be a #{type}, was: #{@[name] || arg-value}"
)

module.exports = ValidateArgs