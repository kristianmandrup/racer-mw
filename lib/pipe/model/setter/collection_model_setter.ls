Class       = require('jsclass/src/core').Class

requires = require '../../../requires'

ModelSetter = requires.pipe 'model/model_setter'

CollectionModelSetter = new Module(
  include:
    * ModelSetter
    ...

  set-name: ->
)

module.exports = CollectionModelSetter