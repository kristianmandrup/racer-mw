Class       = require('jsclass/src/core').Class
util  = require 'util'
lo    = require 'lodash'

PipeTypeValidator = new Class(
  initialize: (@valid-types = []) ->

  validate: (@type) ->
    unless @valid-type!
      throw new Error "Invalid pipe type #{@type} must be one of: #{@valid-types}"
    true

  valid-type: ->
    return true if @no-valid-types!
    @type.to-lower-case! in @valid-types

  no-valid-types: ->
    lo.is-empty @valid-types
)

module.exports = PipeTypeValidator
