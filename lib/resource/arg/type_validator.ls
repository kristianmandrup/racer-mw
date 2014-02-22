Class       = require('jsclass/src/core').Class

lo = require 'lodash'
_  = require 'prelude-ls'
require 'sugar'

require = require '../../../requires'

TypeValidator = new Class(
  initialize: (@args)

  types-map: ->
    @types ||= requires.resource 'type_map'

  validate: ->
    lo.for-own @args, (key, value) ->
      validate-type key, value

  validate-type: (key, value) ->
    unless is-valid key, value
      @error.invalid-type key, value, valid-types

  is-valid: (key, value) ->
    valid-types-for(key).any (valid-type) ->
      typeof value is valid-type

  valid-types-for: (key) ->
    [types-map![key]].flatten
)

module.exports = TypeValidator