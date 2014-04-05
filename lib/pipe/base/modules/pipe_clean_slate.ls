Module    = require('jsclass/src/core').Module

CleanSlate = new Module(
  initialize: ->

  # since not a container pipe!
  allows-child: (type) ->
    false

  parse: (...args) ->
    throw new Error "Only a Container pipe can parse pipes, I am a #{@pipe.type} pipe"

  add: (...args) ->
    throw new Error "Only Container pipes can add pipes, I am a #{@pipe.type} pipe"

  valid-args:     []
  valid-children: []
  valid-parents:  []

  parent-name: ->
  value: ->
)

module.exports = CleanSlate