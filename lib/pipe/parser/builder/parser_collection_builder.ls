Class       = require('jsclass/src/core').Class

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'

requires = require '../../requires'

CollectionPipe    = requires.apipe 'collection'

ParserCollectionBuilder = new Class(
  initialize: ->

  build: (key) ->
    @debug-msg "CollectionPipe: #{key}"
    col-pipe = new CollectionPipe "#{key}": @value
    @debug-msg col-pipe.describe!
    @build-children @value, col-pipe
)
