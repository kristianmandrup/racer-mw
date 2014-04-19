Class       = require('jsclass/src/core').Class
requires    = require '../../../requires'

lo = require 'lodash'
_  = require 'prelude-ls'
require 'sugar'

# concatenates all of the arg hashes into one store
ArgStore = new Class(
  initialize: ->
    self = @
    ['setter', 'basic', 'query', 'reference', 'scoped', 'string'].each (command) ->
      lo.extend self.repo, requires.resource "arg/resource_arg_#{command}"
    @

  repo: {}
)

module.exports = ArgStore
