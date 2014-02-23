Class       = require('jsclass/src/core').Class

require 'sugar'

ParentValidator = new Class(
  initialize: (@parent, @name) ->

  validate: ->
    unless @valid-type!
      throw new Error "Invalid parent pipe for attribute #{name}, must be a ModelPipe"

  valid-type: ->
    @valid-parent-types.include @parent.type

  valid-parent-types: []
)

module.exports = ParentValidator