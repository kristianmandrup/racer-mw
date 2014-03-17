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

  raw-value: (contained) ->
    if @child-count > 0
      obj = {}
      @child-list!.each (child) ->
        obj[child.id!] = child.raw-value true
      if contained then {(@id!): obj} else obj
    else
      @value!

  value: ->
    @value-obj.value

  on-child-update: (child, new-value) ->
    # console.log 'notified', new-value
    if @auto-update
      # recompute raw value
      # console.log 'setting raw value', @raw-value!

      # TODO: For some odd reason the following call doesn't work correctly!! Please shed light on this mystery...
      # @set-value @raw-value!

      setv = @value-obj.set @raw-value!
      if setv
        @parent.on-child-update(@, setv) if @parent
      setv

  auto-update: true

  set-value: (value) ->
    # console.log 'set value', value
    setv = @value-obj.set value
    if setv
      @parent.on-child-update(@, setv) if @parent
    setv
)

module.exports = PipeValue