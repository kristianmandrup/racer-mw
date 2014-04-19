Class   = require('jsclass/src/core').Class
get     = require '../../requires' .get!
_       = require 'prelude-ls'
lo      = require 'lodash'
require 'sugar'

ValueObject = get.value-object 'base'

PrimitiveValueObject = new Class(ValueObject,
  validate: ->
    lo.find @valid-types!, @is-valid-type, @

  is-valid-type: (type) ->
    typeof! @value is 'String'

  valid-types: ->
    <[ String Number ]>
)

module.exports = ObjectValueObject