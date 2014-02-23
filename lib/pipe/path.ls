Class       = require('jsclass/src/core').Class

requires = require '../../requires'

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

PathResolver      = requires.pipe 'path_resolver'
BasePipe          = requires.pipe 'base'

# Must be on a model or attribute
# Useful to set initial model path such as _session or _page etc.
PathPipe = new Class(BasePipe,
  initialize: (@path) ->
    @call-super @path
)