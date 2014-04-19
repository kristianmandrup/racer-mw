Module  = require('jsclass/src/core').Module
get     = require '../../../../../requires' .get!

ClazzExtractor  = get.model-extractor 'clazz'
NameExtractor   = get.model-extractor 'name'
ValueExtractor  = get.model-extractor 'value'

ModelSetter = new Module(
  set-all: ->
    @reset-all!
    @set-clazz!
    @set-name!
    @set-value!
    @

  clear-all: ->
    @_model = void
    @name = void
    @value = void
    @clazz = void

  # or call super?
  set-name: ->
    @name = @model!.name

  set-clazz: ->
    @clazz = @model!.clazz

  # don't use extract.value here!!
  set-value: ->
    @call-super @model!.value

  model: ->
    @_model ||= @model-extractor.extract!

  model-extractor: ->
    new ModelExtractor @obj
)

module.exports = ModelSetter