requires = require '../../../requires'

Class       = require('jsclass/src/core').Class

PipeValidation      = requires.pipe 'pipe_validation'

BaseParser = new Class(
  include:
    * PipeValidation
    ...

  initialize: (@parser) ->
    @parent = @parser.parent
    @debug-on = @parser.debug-on
    @

  parent-type: ->
    @parent.pipe-type if @parent

  build: (type, value, arg) ->
    new @builder(type)(value).build arg

  builder: (type) ->
    builders[type]

  builders:
    model:      ParsedModelBuilder
    collection: ParsedCollectionBuilder
    attribute:  ParsedAttributeBuilder
)

module.exports = BaseParser
