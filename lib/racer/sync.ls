Class   = require('jsclass/src/core').Class
Module  = require('jsclass/src/core').Module
Hash    = require('jsclass/src/core').Hash

requires      = require '../../requires'
lo            = require 'lodash'
_             = require 'prelude-ls'

racer         = require 'racer'

urls =
  mongo: process.env.MONGOLAB_URI || process.env.MONGOHQ_URL || 'localhost:27017/test?auto_reconnect', { safe: true }
  redis: process.env.REDISCLOUD_URL

racer = require 'racer'
http  = require 'http'
server = http.createServer app

store = racer.createStore(
  server  : server
  db      : require('livedb-mongo')(urls.mongo)
  redis   : require('redis-url').connect(urls.redis)
)

server.listen process.env.PORT || 8081

module.exports = new Class(
  initialize: (@racer-store, @options) ->

  current-user: ->
    # the model of the session user
    @_current-user ||= @racer-store.get '_session.user'

  # middleware:
  #  - see middleware and model-mw projects. A complete configured middleware stack, depending on the CRUD action
  #     about to be executed (depending of the type of racer store command)
  # mw-context:
  # - a hash with everything needed to run the middleware
  # - possibly enrich with current-user if not set (if authorization) ??

  execute: (racer-command) ->
    racer-command.middleware.run racer-command.mw-context
)