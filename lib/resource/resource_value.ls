Module  = require('jsclass/src/core').Module

util    = require 'util'

_   = require 'prelude-ls'

requires  = require '../../requires'

ValueObject = requires.lib 'value_object'

ResourceValue = new Module(
  # should use Pipe path to always pre-resolve scope
  # @scoped 'path'
  set-value: (value) ->
    @get-value-obj!.set value

  get-value-obj: ->
    @value-obj ||= new ValueObject

  value: ->
    @value-obj.value
)

module.exports = ResourceValue