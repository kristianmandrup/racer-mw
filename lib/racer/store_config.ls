module.exports =
  # override to set your own!
  racer-store: ->
    @store ||= @default-store!

  # taken from racer-example by @Sebmaster
  default-store: ->
    # see: https://github.com/share/livedb-mongo
    racer       = require 'racer'
    mongoskin   = require 'mongoskin'
    # see https://gist.github.com/fengmk2/1194742
    # see https://github.com/kissjs/node-mongoskin
    # console.log 'mongoskin', mongoskin
    # TypeError: object is not a function ???
    skin        = mongoskin 'localhost:27017/test?auto_reconnect', safe:true
    livedbmongo = require 'livedb-mongo'
    mongo       = livedbmongo skin

    # @live-db @db-urls.mongo

    racer.createStore(
      server  : @server
      db      : mongo
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
    redis: process.env.REDISCLOUD_URL || '127.0.0.1:6379'