Class       = require('jsclass/src/core').Class

requires    = require '../../../../requires'

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'

CollectionValueExtractor = new Class(
  initialize: (@arg) ->
    @
)

module.exports = CollectionValueExtractor