Class       = require('jsclass/src/core').Class
Module      = require('jsclass/src/core').Module

requires    = require '../../requires'
lo          = require 'lodash'
_           = require 'prelude-ls'

RacerSync   = requires.crud 'racer_sync'

Subscribe = new Class(RacerSync,
  extend:
    create: (collection, ids) ->
      new @ collection: collection

  # validation not needed
  # must decorate loaded model
  mw-stack: ->
    {}

  subscribe: (callback) ->
    @model.subscribe @res, callback(err)

  unsubscribe: (callback) ->
    @model.unsubscribe @res, callback(err)

  fetch: (callback) ->
    @model.fetch @res, callback(err)

  unfetch: (callback) ->
    @model.unfetch @res, callback(err)

)

module.exports = Subscribe