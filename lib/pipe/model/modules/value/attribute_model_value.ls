Class       = require('jsclass/src/core').Class
get = require '../../../requires' .get!
_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

# PipeValue = get.base-module 'value'

ObjectValueObject = get.value-object 'object'

# should be using basic ValueObject
AttributeModelValue = new Class(
  # value must be an object
  value-obj-factory: ->
    ObjectValueObject
)

module.exports = AttributeModelValue