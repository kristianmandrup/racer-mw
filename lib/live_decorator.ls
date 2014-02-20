Class       = require('jsclass/src/core').Class

LiveDecorator = new Class(
  initialize: (@vo)

  decorate: (live-obj) ->
    lo.extend @vo, live-obj

)

module.exports = LiveDecorator