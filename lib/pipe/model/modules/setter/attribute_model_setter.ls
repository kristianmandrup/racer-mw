Class = require('jsclass/src/core').Class
get   = require '../../../requires' .get!
ModelSetter = get.model-setter 'model'

AttributeModelSetter = new Module(
  include:
    * ModelSetter
    ...
)

module.exports = AttributeModelSetter