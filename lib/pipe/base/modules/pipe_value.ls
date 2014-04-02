/**
 * User: kmandrup
 * Date: 08/03/14
 * Time: 16:59
 */
Module       = require('jsclass/src/core').Module
Class        = require('jsclass/src/core').Class

requires  = require '../../../../requires'

_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

ValueObject       = requires.lib 'value_object'

FamilyNotifier = requires.pipe 'family/family_notifier'

PipeValue = new Module(
  initialize: ->
    @value-obj = @create-value-obj!

  create-value-obj: ->
    new ValueObject @

  value: ->
    @value-obj.value

  # options can be fx: at: 2 to start inserting at position 2
  set-value: (value, options = {}) ->
    if @value-obj.set value, options
      new FamilyNotifier(@, options).notify-family @value!, options
    @value!
)

module.exports = PipeValue