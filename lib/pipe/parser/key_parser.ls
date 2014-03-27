requires = require '../../../requires'

Class       = require('jsclass/src/core').Class

_     = require 'prelude-ls'

KeyParser = new Class(
  initialize: (@obj) ->
    @keys = _.keys(@obj)
    @

  parse: ->
    @no-keys! or @parse-keys!

  no-keys: ->
    [] if @keys.length is 0

  parse-keys: ->
    @first-mapped! or @mapped

  first-mapped: ->
    @mapped.first! if @mapped.length is 1

  mapped: ->
    @_mapped ||= @map keys

  map: (keys) ->
    self = this
    keys.map (key) ->
      self.map-key key

  map-key: (key) ->
    @parse-tupel key, @obj[key]
)

module.exports = KeyParser