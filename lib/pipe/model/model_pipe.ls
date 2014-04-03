Class       = require('jsclass/src/core').Class
get = require '../../../requires' .get!
_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

BasePipe       = get.apipe        'base'
ContainerPipe  = get.pipe         'container'
ModelSetter    = get.model-setter 'model'

# Must be on a model or attribute
ModelPipe = new Class(BasePipe,
  include:
    * ModelSetter
    * NamedPipe
    * ChildPipe
    ...

  initialize: ->
    @call-super!

  pipe:
    type:       'Model'
    container:  true
    child:      true
    named:      void
    base-type:  'Model'

  id: ->
    throw new Error "Must be implemented by subclass"

  pre-attach-to: (parent) ->
    @call-super!


  valid-children:
    kind: \named
)

module.exports = ModelPipe