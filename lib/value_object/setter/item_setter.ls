Class   = require('jsclass/src/core').Class
get     = require '../../../requires' .get!
_       = require 'prelude-ls'
lo      = require 'lodash'
require 'sugar'

Mutator = new Class(
  initialize: (@list, @index) ->
    @

  new-item: ->
    @list[@index]
)

ItemSetter = new Class(Mutator,
  # compare, only overwrite if different value
  set: (@index) ->
    return if @new-item! is old.item.raw-value!

    if @parser
      item = @parser!.build-model new-item
      console.log 'item', item.describe!
      @container.child-hash[i] = item
)

ItemPusher = new Class(Mutator,
  # compare, only overwrite if different value
  push: (@index) ->
    console.log 'push-item'
    if @parser
      item = @parser!.build-model @new-item!
      @container.attach item
)

module.exports =
  ItemPusher : ItemPusher
  ItemSetter : ItemSetter