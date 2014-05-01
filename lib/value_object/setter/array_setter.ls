Class   = require('jsclass/src/core').Class
get     = require '../../../requires' .get!
_       = require 'prelude-ls'
lo      = require 'lodash'
require 'sugar'

item-setter = get.value-object-setter 'item'
ItemSetter  = item-setter.ItemSetter
ItemPusher  = item-setter.ItemPusher

ArraySetter = new Class(
  initialize: (@value-obj) ->
    if @value-obj is void
      throw new Error "Must take an Array Value Object"
    @value = @value-obj.value || []
    @

  at-pos: ->
    @_at-pos ||= @options.at or 0

  sliced: ->
    @_sliced ||= @value.slice @at-pos!, @list.length

  max-length: ->
    Math.max @sliced!.length, @list.length

  sliced-is-longer: ->
    @sliced!.length > @max-length!

  longest-list: ->
    if @sliced-is-longer! then @sliced! else @list

  set: (@list, @options = {}) ->
    @validate-at-pos!
    @set-list!

  set-list: ->
    for let item, index in @longest-list!
      @set-it(index) or @push-it(index)

  set-it: (index) ->
    @item-settter!.set index unless @no-item-at index

  no-item-at: (index) ->
    not @item-at index

  item-at: (index) ->
    @sliced![index] isnt void

  push-it: (index) ->
    @item-pusher!.push index

  validate-at-pos: ->
    @valid-at-pos! or @at-pos-error!

  at-pos-error: ->
    throw new Error "Index to start insert must be >= 0, was: #{@at-pos!}"

  valid-at-pos: ->
    typeof! @at-pos! is 'Number' and @at-pos! >= 0

  item-pusher: ->
    @_item-pusher ||= new ItemPusher @list

  item-setter: ->
    @_item-pusher ||= new ItemSetter @list
)

module.exports = ArraySetter

