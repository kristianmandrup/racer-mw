module.exports =
  # override to set your own!
  racer-store: ->
    @store ||= @default-store!

  default-store: ->
    # see: https://github.com/share/livedb-mongo
    @racer = require 'racer'
    @local-store!

  local-store: ->
    @racer.createStore(
      redis:   @local-redis!
      db:      @live-db('localhost:27017/test?auto_reconnect', {safe: true})
    )

  remote-store: ->
    @racer.createStore(
      redis:   @redis!
      db:      @mongo!
    )

  databases: ->
    db:    @mongo!
    redis: @redis!

  app: ->
    require('express')

  http: ->
    require 'http'

  server: ->
    @http!.createServer(@app!).listen @port!

  port: ->
    process.env.PORT || 8081

  redis-url: ->
    require('redis-url')

  redis: ->
    @redis-url!.connect(@db-urls.redis)

  # see https://gist.github.com/fengmk2/1194742
  # see https://github.com/kissjs/node-mongoskin
  skin: require('mongoskin')

  mongo: ->
     skinned-mongo! (@db-urls.mongo)

  skinned-mongo: ->
    @live-db(@skin)

  live-db: require('livedb-mongo')

  local-redis: ->
    '127.0.0.1:6379'

  db-urls:
    mongo: process.env.MONGOLAB_URI || process.env.MONGOHQ_URL
    redis: process.env.REDISCLOUD_URL