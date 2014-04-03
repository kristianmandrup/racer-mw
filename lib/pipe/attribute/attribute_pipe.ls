Class       = require('jsclass/src/core').Class

get   = require '../../../requires' .get!

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'

BasePipe                  = get.apipe  'base'
ModelPipe                 = get.apipe  'model'

# Must be on a model or path pipe
AttributePipe = new Class(BasePipe,
  initialize: ->
    @call-super!
    @set-all!
    @post-init!
    @

  pipe:
    type:       'Attribute'
    base-type:  'Attribute'

  id: ->
    @name

  valid-parents: <[attribute-model collection-model path]>

)

module.exports = AttributePipe