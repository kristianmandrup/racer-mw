Class       = require('jsclass/src/core').Class

requires = require '../../requires'

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'

BasePipe                  = requires.apipe  'base'
ModelPipe                 = requires.apipe  'model'
AttributeObjectUnpacker   = requires.pipe   'attribute/attribute_object_unpacker'

unpack = (args) ->
  unpacker(args).unpack!

unpacker = (args) ->
  new AttributeObjectUnpacker args

# Must be on a model or path pipe
AttributePipe = new Class(BasePipe,
  initialize: ->
    @call-super!
    [name, value] = unpack @args
    @set-name name
    @set-value value
    @post-init!
    @

  pipe-type: 'Attribute'

  id: ->
    @name

  # should be the end of the line!!!
  # only simple values can go here, no models or collections!
  # attach: void

  valid-children: void
  has-children:   false

  valid-parents:
    * \model
    * \path

)

module.exports = AttributePipe