Class       = require('jsclass/src/core').Class
requires    = require '../../../requires'

lo = require 'lodash'
_  = require 'prelude-ls'
require 'sugar'

# concatenates all of the arg hashes into one store
ArgStore = new Class(
  initialize: (@name)->
    @populate!

  populate: ->
    self = @
    ['array', 'basic', 'query', 'reference', 'scoped', 'string'].each (command) ->
      lo.extend self.repo, requires.resource "arg/#{command}"
    true

  repo: {}
)

module.exports = ArgStore
