Class     = require('jsclass/src/core').Class

requires  = require '../../../requires'

_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

ParserBuilder = new Class(
  initialize: (@type, @value) ->

  build: (arg, @value) ->
    builder = @create-builder!
    unless builder
      throw new Error "Builder #{@type} could not be created"
    builder.build arg

  create-builder: ->
    clazz = @builder-clazz @type
    new clazz @, @value

  builder-clazz: ->
    requires.pipe "parser/builder/parser_#{@type}_builder"
)

module.exports = ParserBuilder
