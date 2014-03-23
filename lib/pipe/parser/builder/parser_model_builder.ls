Class       = require('jsclass/src/core').Class

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'

requires = require '../../requires'

ModelPipe         = requires.apipe 'model'

ParserModelBuilder = new Class(
  initialize: ->

  build: (key) ->
    return @build-named(key) if key
    @debug-msg "ModelPipe for: #{@value}"
    model-pipe = new ModelPipe @value
    @build-children @value, model-pipe

  build-named: ->
    @debug-msg "ModelPipe named: #{key}"
    model-pipe = new ModelPipe "#{key}": @value
    @build-children @value, model-pipe
)