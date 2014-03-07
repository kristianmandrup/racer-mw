Class       = require('jsclass/src/core').Class

BasePipeBuilder = new Class(
  initialize: (@container) ->

  attach: (pipe) ->
    @container.attach pipe
)

module.exports = BasePipeBuilder