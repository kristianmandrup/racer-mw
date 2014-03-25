Class       = require('jsclass/src/core').Class

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

requires = require '../../requires'

ValueObject = requires.lib 'ValueObject'
Parser      = requires.pipe 'pipe_parser'


# Also enable contract: true option, to contract original array or false: ignore remaining elements

ArrayValueObject = new Class(ValueObject,
  initialize: (@container, options = {}) ->
    @call-super!
    @parser = new Parser(void, parent: @container, debug: true)
    @

  set-value: (list, options = {}) ->
    @valid = @validate list
    val = @set-list list, options if @valid
    console.log 'DONE set-value', val
    val

  set-list: (list, options = {}) ->
    orig-list = @value || []
    index = options.at or 0
    unless typeof! index is 'Number' and index >= 0
      throw new Error "Index to start insert must be >= 0, was: #{index}"

    sliced = orig-list.slice index, list.length
    console.log 'sliced and diced:', sliced

    max-length = Math.max(sliced.length, list)
    max-list = if sliced.length is max-length then sliced else list
    console.log 'max-list', max-list
    for let item, i in max-list
      console.log 'i', i
      if sliced[i]
        @set-item sliced, list[i], i
      else
        @push-item orig-list, list[i]

    @value = @container.raw-value!
    # console.log 'pipe', @container.describe!
    console.log 'VALUE' @value
    @value

  # compare, only overwrite if different value
  set-item: (sliced, new-item, i) ->
    console.log 'set-item'
    return if new-item is old.item.raw-value!

    item = @parser.build-model new-item
    console.log 'item', item.describe!
    @container.child-hash[i] = item

  # compare, only overwrite if different value
  push-item: (list, new-item) ->
    console.log 'push-item'
    item = @parser.build-model new-item
    @container.attach item
)

module.exports = ArrayValueObject