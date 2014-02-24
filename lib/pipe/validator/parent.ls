Class       = require('jsclass/src/core').Class

require 'sugar'
util = require 'util'

ParentValidator = new Class(
  initialize: (@parent, @pipe) ->

  validate: ->
    unless @valid-type!
      throw new Error "Invalid parent pipe for #{util.inspect @pipe} [#{@pipe.type}], must be one of: #{@valid-parent-types}"

  valid-type: ->
    @valid-parent-types.include @parent.type

  valid-parent-types: []
)


module.exports = ParentValidator