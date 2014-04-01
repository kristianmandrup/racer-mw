Class       = require('jsclass/src/core').Class

requires = require '../../../requires'

ClazzExtractor  = requires.pipe 'extractor/clazz_extractor'
NameExtractor   = requires.pipe 'extractor/name_extractor'
ValueExtractor  = requires.pipe 'extractor/value_extractor'

ModelSetter = new Module(
  set-all: ->
    @set-clazz!
    @set-name!
    @set-value!

  # or call super?
  set-name: ->
    @name = @name-extractor.extract!

  set-clazz: ->
    @clazz = @clazz-extractor!.extract!

  # don't use extract.value here!!
  set-value: ->
    @call-super @value-extractor.extract!

  clazz-extractor: ->
    new ClazzExtractor @obj

  value-extractor: ->
    new ValueExtractor @obj

  name-extractor: ->
    new NameExtractor @obj

)

module.exports = ModelSetter