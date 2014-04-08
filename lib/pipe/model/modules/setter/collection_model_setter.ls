Class = require('jsclass/src/core').Class
get   = require '../../../requires' .get!
ModelSetter = get.model-setter 'model'

CollectionModelSetter = new Module(
  include:
    * ModelSetter
    ...

  set-name: ->
)

module.exports = CollectionModelSetter