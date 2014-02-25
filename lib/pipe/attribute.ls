Class       = require('jsclass/src/core').Class

requires = require '../../requires'

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

BasePipe          = requires.pipe 'base'

# Must be on a model
AttributePipe = new Class(BasePipe,
  initialize: (@parent, @name) ->
    @validate!
    @call-super @name

  # should be the end of the line!!!
  # only simple values can go here, no models or collections!


)

module.exports = AttributePipe