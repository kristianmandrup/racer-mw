Class       = require('jsclass/src/core').Class

requires = require '../../requires'

AttributePipe     = requires.apipe 'attribute'

ParserAttributeBuilder = new Class(
  initialize: ->

  build: (key) ->
    @debug-msg "AttributePipe: #{key}, #{@value}"
    new AttributePipe key, @value
)

module.exports = ParserAttributeBuilder
