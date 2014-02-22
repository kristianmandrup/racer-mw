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
    # self = @
    ['array', 'basic', 'query', 'reference', 'scoped', 'string'].each (command) ->
      console.log requires.resource "arg/#{command}"
      # lo.extend self.repo, requires.resource "arg/#{command}"

  repo: {x: 2}
)

module.exports = ArgStore
