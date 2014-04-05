Class       = require('jsclass/src/core').Class

get   = require '../../../requires' .get!

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'

BasePipe                  = get.apipe  'base'
BasePipe          = get.apipe                 'base'
NamedPipe         = get.apipe                 'named'
ChildPipe         = get.apipe                 'child'

# Must be on a model or path pipe
AttributePipe = new Class(BasePipe,
  include:
    * NamedPipe
    * ChildPipe
    ...

  initialize: ->
    @call-super!
    @set-all!
    @post-init!
    @

  pipe:
    type:       'Attribute'
    container:  false
    child:      true
    named:      true
    kind:  'Attribute'

  id: ->
    @name

  valid-parents: <[attribute-model collection-model path]>

)

module.exports = AttributePipe