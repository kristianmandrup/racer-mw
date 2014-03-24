Class       = require('jsclass/src/core').Class

requires = require '../../../../requires'

ModelPipe           = requires.apipe 'model'

ParserBaseBuilder   = requires.pipe 'parser/builder/parser_base_builder'

ParserModelBuilder = new Class(ParserBaseBuilder,
  initialize: (@parser, @value) ->
    @call-super!

  build: (name) ->
    console.log 'build', name
    @build-children @build-model(name)

  build-model: (name) ->
    return @build-named-model name if name
    new ModelPipe @value

  build-named-model: (name) ->
    new ModelPipe("#{name}": @value)
)

module.exports = ParserModelBuilder