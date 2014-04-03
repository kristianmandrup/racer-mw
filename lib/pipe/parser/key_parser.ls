requires = require '../../../requires'

Class    = require('jsclass/src/core').Class

_        = require 'prelude-ls'

parser = ->
  requires.pipe!.parser!

TupleObjectParser = parser!.named 'tuple/tuple_object'

KeyParser = new Class(
  initialize: (@obj) ->
    @validate-obj!
    @keys = _.keys @obj
    @

  validate-obj: ->
    unless typeof! @obj is 'Object'
      throw new TypeError "Must take an Object, was: #{typeof! @obj} - #{@obj}"

  parse: ->
    @parse-no-keys! or @parse-keys!

  parse-no-keys: ->
    [] if no-keys

  no-keys: ->
    @keys.length is 0

  parse-keys: ->
    @first-mapped-key! or @mapped-keys!

  first-mapped-key: ->
    @mapped-keys.first! if @one-mapped-key!

  one-mapped-key: ->
    @mapped-keys.length is 1

  mapped-keys: ->
    @_mapped ||= lo.map @keys, @map-key, @

  map-key: (key) ->
    @tuple-parser(key).parse!

  tuple-parser: (key) ->
    new TupleObjectParser key, @value-for(key)

  value-for: (key) ->
    @obj[key]
)

module.exports = KeyParser