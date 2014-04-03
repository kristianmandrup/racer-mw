Class       = require('jsclass/src/core').Class

requires = require '../../requires'

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

ContainerPipe  = requires.d.pipe 'container'

ModelSetter    = requires.pipe!model!setter!named 'model'

# Must be on a model or attribute
ModelPipe = new Class(ContainerPipe,
  include:
    * ModelSetter
    ...

  initialize: ->
    @call-super!

  pipe:
    type:       'Model'
    base-type:  'Model'

  id: ->
    throw new Error "Must be implemented by subclass"

  pre-attach-to: (parent) ->
    @call-super!

  valid-parents: []
  valid-children: []
)

module.exports = ModelPipe