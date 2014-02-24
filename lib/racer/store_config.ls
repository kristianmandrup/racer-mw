module.exports =
  # override to set your own!
  racer-store: ->
    @store ||= @default-store!

  default-store: ->
    # see: https://github.com/share/livedb-mongo
    racer       = require 'racer'

    racer.createStore(
      server:  @server!
      db:      @databases!
    )

  databases: ->
    db:    @mongo!
    redis: @redis!

  app: ->
    require('express')!

  http: ->
    require 'http'

  server: ->
    @http!.createServer(@app!).listen @port!

  port: ->
    process.env.PORT || 8081

  redis-url: ->
    require('redis-url')

  redis: ->
    @redis-url!.connect @db-urls.redis

  # see https://gist.github.com/fengmk2/1194742
  # see https://github.com/kissjs/node-mongoskin
  skin: ->
    require('mongoskin') @db-urls.mongo

  mongo: ->
    @live-db! @skin!

  live-db: ->
    require('livedb-mongo')

  db-urls:
    mongo: process.env.MONGOLAB_URI || process.env.MONGOHQ_URL || 'localhost:27017/test?auto_reconnect', { safe: true }
    redis: process.env.REDISCLOUD_URL || '127.0.0.1:6379'