Class       = require('jsclass/src/core').Class

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

ValueObject = new Class(
  initialize: (@container, options = {}) ->
    @set-value(options.value, options) if options.value
    @

  set-value: (value, options = {}) ->
    @valid = @validate value
    @value = value if @valid

  # alias
  set: (value, options = {}) ->
    @set-value value

  valid: true

  # use container to determine what validation to perform
  # fx, if container is an AttributePipe called email
  # - check it is a non-empty string
  # - use email validation
  validate: (value, options = {}) ->
    true
)

module.exports = ValueObject