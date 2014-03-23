Class       = require('jsclass/src/core').Class

requires = require '../../../../requires'

ParserBaseBuilder   = requires.pipe 'parser/builder/parser_base_builder'

AttributePipe       = requires.apipe 'attribute'

ParserAttributeBuilder = new Class(ParserBaseBuilder,
  initialize: (@parser, @value)->
    @call-super!

  build: (key) ->
    new AttributePipe key, @value
)

module.exports = ParserAttributeBuilder
