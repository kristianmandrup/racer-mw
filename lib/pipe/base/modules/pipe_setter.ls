Module    = require('jsclass/src/core').Module

PipeSetter = new Module(
  initialize: (...@args) ->
    @set-all!

  # basic set functionality
  # if pipe has no name, just leave set-name function empty
  set-all: ->
    @set-name! unless @name
    @set-value!

  # needs to be decorated with NamedPipe
  set-name: (name) ->

  set-value: ->
)

module.exports = PipeSetter
