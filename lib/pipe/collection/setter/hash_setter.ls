Class       = require('jsclass/src/core').Class

requires  = require '../../../../requires'

_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

ValueHashSetter = new Class(
  initialize: (@pipe, @hash) ->
    @validate!
    @keys =  _.keys(@hash)
    @

  validate: ->
    unless typeof! @hash is 'Object'
      throw new Error "Must be an Object, was #{typeof! @hash} - #{@hash}"

  set-value: ->
    @set-value-by-list! if @number-keys

  number-keys: ->
    lo.every @keys, @is-number

  is-number: (key) ->
    not isNaN key

  # set-value-at 3: [x, y, z], 6: [a, b]
  set-by-index-lists: ->
    for index, list of @hash
      @pipe.set-value list, at: index
)

module.exports = ValueHashSetter