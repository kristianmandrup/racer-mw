Class       = require('jsclass/src/core').Class

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'

requires = require '../../requires'

ModelPipe         = requires.apipe 'model'

ParserModelBuilder = new Class(
  initialize: (@value)->
    @call-super!

  build: (key) ->
    return @build-named(key) if key
    @build-children @value, new ModelPipe(@value)

  build-named: ->
    @build-children @value, new ModelPipe("#{key}": @value)
)