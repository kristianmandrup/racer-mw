Class       = require('jsclass/src/core').Class

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

ValueObject = new Class(
  initialize: (@value) ->
    @valid = @validate @value

  valid: true

  validate: ->
    true
)

module.exports = ValueObject