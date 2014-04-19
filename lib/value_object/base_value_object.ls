Class = require('jsclass/src/core').Class
_     = require 'prelude-ls'
lo    = require 'lodash'
require 'sugar'

ValueObject = new Class(
  initialize: (@options = {}) ->
    @validate-args!
    @valid = true
    @set-value @options.value
    @

  validate-args: ->
    throw new Error "Missing value" unless @options.value

  set-value: (@value) ->
    @valid = @validate!
    @value = void if @is-invalid!
    @

  # alias
  set: (value) ->
    @set-value value

  is-valid: ->
    @valid

  is-invalid: ->
    not @valid

  # use container to determine what validation to perform
  # fx, if container is an AttributePipe called email
  # - check it is a non-empty string
  # - use email validation
  validate: ->
    true
)

module.exports = ValueObject