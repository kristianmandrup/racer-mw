Module  = require('jsclass/src/core').Module
get     = require '../../../../../requires' .get!

ModelExtractor  = get.model-extractor 'model'

ModelSetter = new Module(
  set-all: ->
    @reset-all!
    @set-clazz!
    @set-name!
    @set-value!
    @

  reset-all: ->
    @_model = void
    @name = void
    @value = void
    @clazz = void

  # or call super?
  set-name: ->
    @name = @model!.name
    @

  set-clazz: ->
    @clazz = @model!.clazz
    @

  set-value: ->
    @value = @model!.value
    @

  model: ->
    @_model ||= @model-extractor!.extract!

  model-extractor: ->
    new ModelExtractor @obj
)

module.exports = ModelSetter