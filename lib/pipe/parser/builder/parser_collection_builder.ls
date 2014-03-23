Class       = require('jsclass/src/core').Class

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'

requires = require '../../requires'

CollectionPipe    = requires.apipe 'collection'

ParserCollectionBuilder = new Class(
  initialize: (@value)->
    @call-super!

  build: (key) ->
    @build-children build-collection!

  build-collection: ->
    new CollectionPipe("#{key}": @value)
)
