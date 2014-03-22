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

  # sent to child pipe
  on-parent-update: (parent, value) ->
    return unless @auto-update
    @set-value value

  # sent to parent pipe
  on-child-update: (child, value) ->
    return unless @auto-update
    @set-value value

  auto-update: true

  # TODO: improve of FamilyNotifier
  set-value: (value) ->
    updated-value = @value-obj.set value

    if updated-value
      # only updates existing children. What if value should create additional children?
      # We need a way to check if value contains new children to be created, then create them
      # These newly created children should not be notified, so should be created after Family is Notified...
      new FamilyNotifier(@).notify-family updated-value
      @post-set-value value
    updated-value

  post-set-value: (value) ->
)

module.exports = PipeValue