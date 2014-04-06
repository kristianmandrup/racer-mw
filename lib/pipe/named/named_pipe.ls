Module      = require('jsclass/src/core').Module

NamedPipe = new Module(
  initialize: (...args) ->
    @call-super!
    @

  set-name: (name) ->
    @name = name
    @call-super!
)

module.exports = NamedPipe