Module    = require('jsclass/src/core').Module

PipeSetter = new Module(
  initialize: (...@args) ->
    @set-all!

  # basic set functionality
  # if pipe has no name, just leave set-name function empty
  set-all: ->
    @set-name!
    @set-value!

  set-name: (name) ->
    @name = name

  set-value: ->
)

module.exports = PipeSetter
