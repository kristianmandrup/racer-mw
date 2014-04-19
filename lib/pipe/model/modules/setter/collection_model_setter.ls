Module  = require('jsclass/src/core').Module
get     = require '../../../../../requires' .get!

ModelSetter = get.model-setter 'model'

CollectionModelSetter = new Module(
  include:
    * ModelSetter
    ...

  set-name: ->
    @name = void
    @

  set-value: ->
    @value = @normalized-value @model!.value
    @

  normalized-value: (obj) ->
    [] if typeof! obj is 'Object'
)

module.exports = CollectionModelSetter