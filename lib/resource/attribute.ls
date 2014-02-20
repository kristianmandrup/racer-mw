Class       = require('jsclass/src/core').Class

require = require '../../requires'

requires.resource 'base'

AttributeResource = new Class(BaseResource,
  # value-object
  initialize: (@value-object)

  $inc: (num, path) ->
    @perform 'increment', path, by: num
)

module.exports = AttributeResource