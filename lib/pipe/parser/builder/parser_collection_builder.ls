Class       = require('jsclass/src/core').Class

requires = require '../../../../requires'

ParserBaseBuilder   = requires.pipe 'parser/builder/parser_base_builder'

CollectionPipe    = requires.apipe 'collection'

ParserCollectionBuilder = new Class(ParserBaseBuilder,
  initialize: (@parser, @value)->
    @call-super!

  build: (key) ->
    @build-children @build-collection!

  build-collection: ->
    new CollectionPipe("#{key}": @value)
)

module.exports = ParserCollectionBuilder