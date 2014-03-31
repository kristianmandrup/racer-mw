Class       = require('jsclass/src/core').Class

requires = require '../../requires'

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'

BasePipe                  = requires.apipe  'base'
ModelPipe                 = requires.apipe  'model'
AttributeObjectUnpacker   = requires.pipe   'attribute/attribute_object_unpacker'

# Must be on a model or path pipe
AttributePipe = new Class(BasePipe,
  initialize: ->
    @call-super!
    @set-all!
    @post-init!
    @

  unpacked: ->
    @_unpacked ||= new AttributeObjectUnpacker(@args).unpack!

  pipe:
    type:       'Attribute'
    base-type:  'Attribute'

  id: ->
    @name

  valid-parents: <[attribute-model collection-model path]>

)

module.exports = AttributePipe