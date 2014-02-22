Class       = require('jsclass/src/core').Class
requires    = require '../../../../requires'

lo = require 'lodash'
_  = require 'prelude-ls'
require 'sugar'

TypeValidator = new Class(
  initialize: (@args) ->

  type-map: ->
    @map ||= requires.resource 'arg/validation/type_map'

  validate: ->
    valid = false
    return true unless @args
    for key, value of @args
      valid = @validate-type key, value
      break if valid
    valid

  validate-type: (key, value) ->
    return false unless @is-valid key, value
    true
    # @error.invalid-type key, value, @valid-types-for(key)

  is-valid: (key, value) ->
    @valid-types-for(key).any (valid-type) ->
      typeof value is valid-type

  valid-types-for: (key) ->
    [@type-map![key]].flatten!
)

module.exports = TypeValidator