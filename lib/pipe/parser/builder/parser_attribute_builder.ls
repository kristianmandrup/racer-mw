Class       = require('jsclass/src/core').Class

requires = require '../../requires'

AttributePipe     = requires.apipe 'attribute'

ParserAttributeBuilder = new Class(
  initialize: (@value)->
    @call-super!

  build: (key) ->
    new AttributePipe key, @value
)

module.exports = ParserAttributeBuilder
