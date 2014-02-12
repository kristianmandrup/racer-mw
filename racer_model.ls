# TODO:
# See https://github.com/Sebmaster/racer-example and change accordingly :)

derby = require('derby');
express = require('express');

liveDbMongo = require('livedb-mongo');
MongoStore = require('connect-mongo')(express);

# Get Redis configuration
if (process.env.REDIS_HOST)
  redis = require('redis').createClient(process.env.REDIS_PORT, process.env.REDIS_HOST)
  redis.auth(process.env.REDIS_PASSWORD)
else if (process.env.REDISCLOUD_URL)
  redisUrl = require('url').parse(process.env.REDISCLOUD_URL)
  redis = require('redis').createClient(redisUrl.port, redisUrl.hostname)
  redis.auth(redisUrl.auth.split(":")[1])
else
  redis = require('redis').createClient()
redis.select(process.env.REDIS_DB || 1);

# Get Mongo configuration
mongoUrl = process.env.MONGO_URL || process.env.MONGOHQ_URL ||
  'mongodb://localhost:27017/project'

# The store creates models and syncs data
# do we really need this!?
store = derby.createStore(
  db: liveDbMongo(mongoUrl + '?auto_reconnect', {safe: true})
, redis: redis
)

# when using express
createUserId(req, res, next) ->
  model = req.getModel()
  userId = req.session.userId || (req.session.userId = model.id());
  model.set('_session.userId', userId);

#  .use(express.session(
#    secret: process.env.SESSION_SECRET || 'YOUR SECRET HERE'
#  , store: new MongoStore(url: mongoUrl, safe: true)
#  ))
#  .use(createUserId)


crud = (collection) ->
  new Models.Crud collection

crud('users').get(id).one
crud('users').get!.one(id)

users = crud('users')
users.get!.one(id)
users.get!.by(name: name).first
users.get!.by(name: name).all