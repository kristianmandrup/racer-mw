requires = require '../../../requires'

Class    = require('jsclass/src/core').Class

_        = require 'prelude-ls'

TupleObjectParser = requires.pipe 'parser/tuple/tuple_object_parser'

KeyParser = new Class(
  initialize: (@obj) ->
    unless typeof! @obj is 'Object'
      throw new TypeError "Must take an Object, was: #{typeof! @obj} #{@obj}"
    @keys = _.keys(@obj)
    @

  parse: ->
    @no-keys! or @parse-keys!

  no-keys: ->
    [] if @keys.length is 0

  parse-keys: ->
    @first-mapped! or @mapped!

  first-mapped: ->
    @mapped.first! if @mapped.length is 1

  mapped: ->
    @_mapped ||= @map-keys!

  map-keys: ->
    self = this
    @keys.map (key) ->
      self.map-key key

  map-key: (key) ->
    @tuple-parser(key).parse!

  tuple-parser: (key) ->
    new TupleObjectParser key, @value-for(key)

  value-for: (key) ->
    @obj[key]
)

module.exports = KeyParser