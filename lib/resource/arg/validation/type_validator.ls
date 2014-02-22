Class       = require('jsclass/src/core').Class
requires    = require '../../../../requires'

lo = require 'lodash'
_  = require 'prelude-ls'
require 'sugar'

TypeValidator = new Class(
  initialize: (@error, @args) ->

  type-map: ->
    @map ||= requires.resource 'arg/validation/type_map'

  validate: ->
    return unless @args
    for key, value of @args
      @validate-type key, value
    true

  validate-type: (key, value) ->
    return true if @is-valid key, value
    @error.invalid-type key, value, @valid-types-for(key)

  is-valid: (key, value) ->
    @valid-types-for(key).any (valid-type) ->
      typeof value is valid-type

  valid-types-for: (key) ->
    [@type-map![key]].flatten!
)

module.exports = TypeValidator