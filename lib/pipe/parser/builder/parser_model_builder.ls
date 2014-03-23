Class       = require('jsclass/src/core').Class

requires = require '../../../../requires'

ModelPipe           = requires.apipe 'model'

ParserBaseBuilder   = requires.pipe 'parser/builder/parser_base_builder'

ParserModelBuilder = new Class(ParserBaseBuilder,
  initialize: (@value) ->
    @call-super!

  build: (key) ->
    return @build-named(key) if key
    @build-children @value, new ModelPipe(@value)

  build-named: (name) ->
    @build-children @value, new ModelPipe("#{name}": @value)
)

module.exports = ParserModelBuilder