Class       = require('jsclass/src/core').Class

requires = require '../../../requires'

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

BasePipe          = requires.d.pipe 'base'

# Must be on a model or attribute
# Useful to set initial model path containers such as '_session' or '_page' etc.
PathPipe = new Class(BasePipe,
  initialize: ->
    @call-super!
    @

  pipe:
    type:       'Path'
    base-type:  'Path'

  has-resource: false

  valid-parents:
    * \path

  valid-children:
    * \attribute
    * \attribute-model
    * \collection
)

module.exports = PathPipe