Module    = require('jsclass/src/core').Module
get       = require '../../../../requires' .get!
_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

PipeRetriever = new Module(
  get: (index) ->
    @pipe-indexer.get index

  pipe-indexer: ->
    @_pipe-indexer ||= new PipeIndexHelper @

  first: ->
    @get 0

  last: ->
    @get @child-count
)

module.exports = PipeRetriever