Class     = require('jsclass/src/core').Class

requires  = require '../../../requires'

_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

ParserBuilder = new Class(
  initialize: (@type, @value) ->

  build: (arg, @value) ->
    unless @create-builder!
      throw new Error "Builder #{@type} could not be created"
    @create-builder.build arg

  create-builder: ->
    @c-builder ||= new @builder-clazz(@type) @ @value

  builder-clazz: ->
    requires.pipe "parser/builder/parser_#{@type}_builder"
)

module.exports = ParserBuilder
