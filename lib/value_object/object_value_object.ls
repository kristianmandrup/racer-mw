Class   = require('jsclass/src/core').Class
get     = require '../../requires' .get!
_       = require 'prelude-ls'
lo      = require 'lodash'
require 'sugar'

ValueObject = get.value-object 'base'

ObjectValueObject = new Class(ValueObject,
  validate: (value) ->
    typeof! value is 'Object'
)

module.exports = ObjectValueObject