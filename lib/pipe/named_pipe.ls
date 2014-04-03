Module      = require('jsclass/src/core').Module
get         = require '../../requires' .get!

NamedPipe = new Module(
  initialize: (...args) ->
    @call-super!
    @

)

module.exports = NamedPipe