/**
 * User: kmandrup
 * Date: 08/03/14
 * Time: 16:59
 */
Module       = require('jsclass/src/core').Module
Class        = require('jsclass/src/core').Class

requires  = require '../../requires'

_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

ValueObject       = requires.lib 'value_object'

RawExtractor = new Class(
  initialize: (@pipe, @obj, @contained) ->
    @pipe-type = @pipe.pipe-type

  id: ->
    @pipe.id!

  inner-raw: ->
    return {(@id!): @obj} if @contained
    @obj

  child-value: (child) ->
    return child.raw-value! if @pipe-type is 'Collection'
    child.raw-value true
)

FamilyNotifier = requires.pipe 'family/family_notifier'

PipeValue = new Module(
  initialize: ->
    @value-obj = new ValueObject @

  raw-value: (contained) ->
    if @child-count > 0
      obj = {}
      raw-extractor = new RawExtractor @, obj, contained
      @child-list!.each (child) ->
        obj[child.id!] = raw-extractor.child-value(child)
      raw-extractor.inner-raw obj
    else
      @value!

  value: ->
    @value-obj.value

  on-parent-update: (parent, new-value) ->
    # console.log 'on-parent-update', new-value
    return unless @auto-update

    # TODO: For some odd reason the following call doesn't work correctly!! Please shed light on this mystery...
    # @set-value new-value

    updated-value = @value-obj.set value

    if updated-value
      new FamilyNotifier(@).notify-family updated-value
    updated-value

  on-child-update: (child, new-value) ->
    # console.log 'on-child-update', new-value
    # console.log 'notified', new-value
    return unless @auto-update
    # recompute raw value
    # console.log 'update parent', new-value, @raw-value!
    # TODO: For some odd reason the following call doesn't work correctly!! Please shed light on this mystery...
    @set-value @raw-value!
    /*
    updated-value = @value-obj.set value

    if updated-value
      new FamilyNotifier(@).notify-family updated-value
    updated-value
    */

  auto-update: true

  set-value: (value) ->
    # console.log 'set-value', value
    updated-value = @value-obj.set value

    if updated-value
      new FamilyNotifier(@).notify-family updated-value
    updated-value
)

module.exports = PipeValue