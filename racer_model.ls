# TODO:
# See https://github.com/Sebmaster/racer-example and change accordingly :)
# Also see http://derbyjs.com/#models

racer = require('racer')
express = require('express')

app = express!
http = require('http')
server = http.createServer(app)

# Get Mongo configuration
mongoUrl = process.env.MONGO_URL || process.env.MONGOHQ_URL || 'localhost:27017/test?auto_reconnect'

app.use(express.static(__dirname + '/public'))
app.use(require('racer-browserchannel')(store))
liveDbMongo = require('livedb-mongo')
MongoStore = require('connect-mongo')(express)

store = racer.createStore(
  server: server
  db: require('livedb-mongo')(mongoUrl, safe: true)
  redis: require('redis-url').connect(process.env.REDISCLOUD_URL)
)

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
redis.select(process.env.REDIS_DB || 1)

# when using express
createUserId(req, res, next) ->
  model = req.getModel()
  userId = req.session.userId || (req.session.userId = model.id())
  model.set('_session.userId', userId)

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