Class       = require('jsclass/src/core').Class

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'

requires = require '../../requires'

CollectionPipe    = requires.apipe 'collection'
AttributePipe     = requires.apipe 'attribute'
ModelPipe         = requires.apipe 'model'
PathPipe          = requires.apipe 'path'

PipeValidation = requires.pipe 'validator/pipe_validation'
PipeParser    = requires.pipe 'pipe_parser'


parsed-builders =
  model:      ParsedModelBuilder
  collection: ParsedCollectionBuilder
  attribute:  ParsedAttributeBuilder

PipeParseBuilder = new Class(
  initialize: (@parser, @value) ->
    @

  # arg is usually a string key
  build: (type, arg) ->
    new parsed-builder(type, @value).build arg

  parsed-builder: (type) ->
    parsed-builders[type]
)

module.exports = PipeParseBuilder