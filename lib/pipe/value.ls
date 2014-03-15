/**
 * User: kmandrup
 * Date: 08/03/14
 * Time: 16:59
 */
Module       = require('jsclass/src/core').Module

requires  = require '../../requires'

_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

ValueObject       = requires.lib 'value_object'

PipeValue = new Module(
  initialize: ->
    @value-obj = new ValueObject @

  value: ->
    @value-obj.value

  set-value: (value) ->
    @value-obj.set value
)

module.exports = PipeValue