Class   = require('jsclass/src/core').Class
get     = require '../../../../../requires' .get!
lo  = require 'lodash'
require 'sugar'

NameExtractor   = get.model-extractor 'name'
ValueExtractor  = get.model-extractor 'value'
ClazzExtractor  = get.model-extractor 'clazz'

ModelExtractor = new Class(
  initialize: (@obj) ->
    @validate!
    @

  validate: ->
    if @obj is void
      throw new Error "A Model cannot be extracted from void"

  extract: ->
    {name: @name!, clazz: @clazz!, value: @value!}

  # or call super?
  name: ->
    @_name ||= @name-extractor!.extract!

  clazz: ->
    @_clazz ||= @clazz-extractor!.extract!

  # don't use extract.value here!!
  value: ->
    @_value ||= @value-extractor!.extract!

  clazz-extractor: ->
    @clz-ex ||= new ClazzExtractor @obj

  value-extractor: ->
    @val-ex ||= new ValueExtractor @obj

  name-extractor: ->
    @nam-ex ||= new NameExtractor @obj
)

module.exports = ModelExtractor