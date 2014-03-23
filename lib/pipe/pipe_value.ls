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
    @value-obj = @create-value-obj!

  create-value-obj: ->
    new ValueObject @

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

  # sent to child pipe
  on-parent-update: (parent, value, options = {}) ->
    return unless @auto-update
    @set-value value, parent: true

  # sent to parent pipe
  on-child-update: (child, value, options = {}) ->
    return unless @auto-update
    @set-value value, child: true

  auto-update: true

  # options can be fx: at: 2 to start inserting at position 2
  set-value: (value, options = {}) ->
    updated-value = @value-obj.set value, options
    if updated-value
      @pre-notify-value value, options
      new FamilyNotifier(@, options).notify-family updated-value, options

      @post-notify-value value, options
    updated-value

  pre-notify-value: (value, options = {}) ->

  post-notify-value: (value, options = {}) ->
)

module.exports = PipeValue