requires = require '../../../requires'

Class    = require('jsclass/src/core').Class

_        = require 'prelude-ls'

TupleObjectParser = requires.pipe 'parser/tuple/tuple_object_parser'

KeyParser = new Class(
  initialize: (@obj) ->
    @validate-obj!
    @keys = _.keys @obj
    @

  validate-obj: ->
    unless typeof! @obj is 'Object'
      throw new TypeError "Must take an Object, was: #{typeof! @obj} - #{@obj}"

  parse: ->
    @no-keys! or @parse-keys!

  no-keys: ->
    [] if @keys.length is 0

  parse-keys: ->
    @first-mapped-key! or @mapped-keys!

  first-mapped-key: ->
    @mapped-keys.first! if @mapped-keys.length is 1

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