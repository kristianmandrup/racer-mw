Class       = require('jsclass/src/core').Class

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

ValueObject = new Class(
  initialize: (@container)

  set-value: (value) ->
    @valid = @validate value
    @value = value if @valid

  # alias
  set: (value) ->
    @set-value value

  valid: true

  # use container to determine what validation to perform
  # fx, if container is an AttributePipe called email
  # - check it is a non-empty string
  # - use email validation
  validate: (value) ->
    true
)

module.exports = ValueObject