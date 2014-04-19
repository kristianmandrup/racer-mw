Module  = require('jsclass/src/core').Module
get     = require '../../../../../requires' .get!

ModelSetter = get.model-setter 'model'

AttributeModelSetter = new Module(
  include:
    * ModelSetter
    ...
)

module.exports = AttributeModelSetter