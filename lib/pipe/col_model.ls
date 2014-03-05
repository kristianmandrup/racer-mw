Class       = require('jsclass/src/core').Class

requires = require '../../requires'

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

ModelPipe          = requires.pipe 'model'


# Must be on a model or attribute
ColModelPipe = new Class(ModelPipe,

  initialize: ->
    @call-super!

  id: ->
    @id