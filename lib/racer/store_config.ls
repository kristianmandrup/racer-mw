module.exports =
  # override to set your own!
  racer-store: ->
    @store ||= default-store!

  # taken from racer-example by @Sebmaster
  default-store: ->
    racer = require 'racer'
    racer.createStore(
      server  : @server
      db      : @live-db @db-urls.mongo
      redis   : @redis!.connect(@db-urls.redis)
    )

  app: ->
    require('express')!

  http: ->
    require 'http'

  server: ->
    @http.createServer(@app).listen @port

  port: ->
    process.env.PORT || 8081

  redis: ->
    require('redis-url')

  live-db: ->
    require('livedb-mongo')

  db-urls:
    mongo: process.env.MONGOLAB_URI || process.env.MONGOHQ_URL || 'localhost:27017/test?auto_reconnect', { safe: true }
    redis: process.env.REDISCLOUD_URL