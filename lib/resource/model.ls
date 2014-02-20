Class       = require('jsclass/src/core').Class

require = require '../../requires'

requires.resource 'base'

ModelResource = new Class(BaseResource,
  # value-object
  initialize: (@value-object)

  $inc: (path, num) ->
    @perform 'increment', path: path, by: num

)

module.exports = ModelResource