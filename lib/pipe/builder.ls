Class       = require('jsclass/src/core').Class

PipeBuilder = new Class(
  initialize: (@container) ->

  attach: (pipe) ->
    @container.attach pipe
)

module.exports = PipeBuilder