Class       = require('jsclass/src/core').Class
requires    = require '../../../../requires'

lo = require 'lodash'
_  = require 'prelude-ls'
require 'sugar'

TypeValidator = new Class(
  initialize: (@args)

  types-map: ->
    @types ||= requires.resource 'arg/validation/type_map'

  validate: ->
    lo.for-own @args, (key, value) ->
      validate-type key, value

  validate-type: (key, value) ->
    unless @is-valid key, value
      @error.invalid-type key, value, valid-types

  is-valid: (key, value) ->
    @valid-types-for(key).any (valid-type) ->
      typeof value is valid-type

  valid-types-for: (key) ->
    [@types-map![key]].flatten!
)

module.exports = TypeValidator