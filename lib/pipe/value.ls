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
  # override if necessary
  get-value: ->
    void

  value: ->
    return @value-obj.value unless @value-obj is void
    @get-value!

  set-value: (value) ->
    if @validate-value value
      @value-obj = new ValueObject(@).set value
    @
)

module.exports = PipeValue