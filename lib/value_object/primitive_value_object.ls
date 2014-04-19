Class   = require('jsclass/src/core').Class
get     = require '../../requires' .get!
_       = require 'prelude-ls'
lo      = require 'lodash'
require 'sugar'

ValueObject = get.value-object 'base'

PrimitiveValueObject = new Class(ValueObject,
  validate: ->
    return true if lo.find @valid-types!, @is-valid-type, @
    false

  is-valid-type: (type) ->
    typeof! @value is type

  valid-types: ->
    <[ String Number ]>
)

module.exports = PrimitiveValueObject