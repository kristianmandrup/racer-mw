Module       = require('jsclass/src/core').Module

Debugging = new Module(
  debug-on: false
  debug: ->
    @debug-on = true

  debug-off: ->
    @debug-on = false

  debug-msg: (msg) ->
    console.log msg if @debug-on is true
)

module.exports = Debugging