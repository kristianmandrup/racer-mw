Module       = require('jsclass/src/core').Module

TupleValidator = new Module(
  validate-array-value: (msg = 'value')->
    unless typeof! @value is 'Array'
      throw new Error "#{msg} must be an Array, was: #{typeof! @value} #{util.inspect @value}"

  validate-string-key: ->
    unless typeof! @key is 'String'
      throw new Error "Key must be a String, was: #{typeof! @key}, #{util.inspect @key}"
)

module.exports = TupleValidator