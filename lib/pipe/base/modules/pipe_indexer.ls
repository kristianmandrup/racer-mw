Module    = require('jsclass/src/core').Module
get       = require '../../../../requires' .get!
_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

PipeIndexer = new Class(
  initialize: (@pipe) ->
    @

  get: (@index) ->
    lo.find @types, @find-type, @

  types: ->
    <[ number string none ]>

  find-type: (type) ->
    @[type] if typeof! @index is type

  number: ->
    @get-by-index!

  string: ->
    @pipe.child @index

  none: ->
    throw new Error "Must be a Number index or name of a child, was: #{index} #{typeof! index}"

  # TODO: refactor
  get-by-index: ->
    @validate-index!
    @child-list![@index]

  child-count: ->
    @pipe.child-count

  validate-index: ->
    @overbound-index!
    @negative-index!

  overbound-index: ->
    if @is-overbound!
      throw new Error "Index #{index} too high, Pipe has #{num} children"

  is-overbound: ->
    @index >= @child-count!

  negative-index: ->
    if @is-negative
      throw new Error "Index must be 0 or higher, was: #{@index}"

  is-negative: ->
    @index < 0
)

module.exports = PipeIndexer