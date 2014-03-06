Class       = require('jsclass/src/core').Class

requires = require '../../requires'

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

util  = require 'util'

ModelPipe          = requires.pipe 'model'


# Must be on a model or attribute
ColModelPipe = new Class(ModelPipe,

  initialize: ->
    console.log 'init ColPipe', util.inspect(arguments)
    @call-super!
    @

  type: 'Pipe'
  pipe-type: 'Model'

  id: ->
    @_id || @id-parent!

  id-parent: ->
    unless @parent
      throw new Error "Can't return id since no parent collection and no internal ID set"

    _.keys(@parent.children).length
)

module.exports = ColModelPipe