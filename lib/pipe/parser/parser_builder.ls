Class     = require('jsclass/src/core').Class

requires  = require '../../../requires'

_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

ParserBuilder = new Class(
  initialize: (@type, @value) ->
    @validate-type!
    @

  validate-type: ->
    unless typeof! @type is 'String'
      throw new TypeError "First arg type must be a String, was: #{typeof @type} - #{@type}"

  build: (arg, @value) ->
    @validate-builder!
    @create-builder!.build arg

  validate-builder: ->
    unless @create-builder!
      throw new Error "Builder #{@type} could not be created"

  create-builder: ->
    @c-builder ||= new @builder-clazz(@type) @, @value

  builder-clazz: ->
    requires.pipe "parser/builder/parser_#{@type}_builder"
)

module.exports = ParserBuilder
