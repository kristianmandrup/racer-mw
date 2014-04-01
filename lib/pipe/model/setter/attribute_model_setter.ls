Class       = require('jsclass/src/core').Class

requires = require '../../../requires'

ModelSetter = requires.pipe 'model/model_setter'

AttributeModelSetter = new Module(
  include:
    * ModelSetter
    ...
)

module.exports = AttributeModelSetter