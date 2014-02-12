# See authorize-mw and validator-mw etc. (on my github: kristianmandrup) for real functioning middleware code!

# The following are mainly some ideas for integration with Angular.js and Racer.js
# The code is written in LiveScript, very similar to CoffeeScript (only much better!!)
# see http://livescript.net

Class   = require('jsclass/src/core').Class
Module  = require('jsclass/src/core').Module
Module  = require('jsclass/src/core').Hash

_ = require 'prelude-ls'
racer = require 'racer'

middleware = require 'middleware'
Middleware = middleware.Middleware

# https://github.com/kristianmandrup/authorize-mw
authorize-mw = require('authorize-mw').AuthorizeMw

# https://github.com/kristianmandrup/validator-mw
validate-mw = require('validator-mw').ValidateMw

# TODO: fix this!
store = racer.store

app ||= {}
app.model = store.createModel!

crud =
  utils : void


# model.query returns and abstract query. You have to pass it as argument to model.subscribe or model.fetch to get the results. Try this:

# query = model.query 'users', where: {name: 'Lars'}
# model.subscribe query, (err, users) ->
  # console.log users.get()

crud.utils.Getter =
  get-one: ->
    @res.get!

  get-all: ->
    @res.fetch (err) ->
      throw Error "Error: Get.one #{err}" if err
      items.get!

RacerSync = new Class(
  initialize: (@context) ->
    unless _.is-type 'Object', @context
      throw Error "Context object must be a Hash, was: #{@context}"

    @model      = @context.model || app.model

    throw Error "Must take a collection hash argument" unless @context.collection
    @collection = @context.collection
    @ids        = @context.ids
    @id         = @context.id     || @ids.first
    @items      = @context.items
    @item       = @context.item   || @items.first

  current-user: ->
    # the model of the session user
    @user ||= model.get '_session.user'

  racer-middleware: ->
    @mw ||= new Middleware('model').use mw-stack!

  mw-stack: ->
    new Hash auth: authorize-mw, validate: validate-mw, racer: racer-mw

  # hash
  stack: (mws) ->
    lo.extend @call-super, mws

  # TODO
  stack-before: (mws) ->

  item-path: ->
    @spath ||= @collection + '.' + @item

  # generator function to be used on some other query
  own: (query, args) ->
    # own-key = args.key || @owner-key
    own-key = @owner-key
    lo.extend @[query](args), "#{own-key}": @current-user!.id

  perform: (act, items) ->
    switch typeof items
    case 'array'
      items.each (item) ->
        @perform act, item
    case 'string'
      @model[act] @item-path
    case void
      @model[act] @collection
    default
      throw Error "Unknown type of item: #{items} to #{act} on"

  exec: (args) ->
    @racer-middleware.run args
)

# model.query returns and abstract query. You have to pass it as argument to model.subscribe or model.fetch to get the results. Try this:

# query = model.query 'users', where: {name: 'Lars'}
# model.subscribe query, (err, users) ->
  # console.log users.get()

Models =
  Utils : void

Models.Utils.Getter =
  get-one: ->
    @res.get!

  get-all: ->
    @res.fetch (err) ->
      throw Error "Error: Get.one #{err}" if err
      items.get!

Models.Get = new Class(RacerSync,
  include: Models.Utils.Getter

  extend:
    create: (collection, ids) ->
      new @ collection: collection, ids: ids

  mw-stack: ->
    stack decorate: middlewares.decorate-mw

  one: (id) ->
    id ||= @id
    throw Error "No id set for #{@collection}" unless id
    @res = @perform 'at', id

  all: ->
    @res = @perform 'get'

  # allow combination such as own selected, f.ex via passing generator function
  these: (ids) ->
    ids ||= @ids
    return @all! unless _.is-type 'Array', ids
    @res = model.query _id: {$in: ids}

  exec: (select) ->
    @callSuper action: 'read', data: @[select], collection: @collection
)

Models.Set = new Class(RacerSync,
  extend:
    create: (collection, items) ->
      new @ collection: collection, items: items

  # marshal-mw
  # filters any local data that should not be stored (depending on context)
  # similar to decorator
  # should be used after validation before racer-mw
  mw-stack: ->
    stack-before 'racer-mw', marshal: middlewares.marshal-mw

  one: ->
    @perform 'set', @item

  # should be generator function to be used on
  own: (fun, key) ->
    @my-own(@[fun], @item)

  # push array
  many: ->
    @perform 'set', @items
)

Models.Delete = new Class(RacerSync,
  initialize: (@context) ->
    @callSuper!
    @getter = new Models.Get @context

  extend:
    create: (collection, ids) ->
      new @ collection: collection, ids: ids

  one: ->
    @perform 'del', @getter.one!

  # delete array
  selected: ->
    selection @getter.selected!

  selection: (list) ->
    list.each (item) ->
      @one item._id

  all: ->
    model.destroy!
)

Models.Crud = new Class(
  initialize (@collection) ->
    @model = app.model

  extend:
    create: (args) ->
      # new @

  ctx: (ctx) ->
    lo.extend {collection: @collection}, ctx

  factory: (name) ->
    switch typeof arguments
    case 'object'
      new Models.call(name) @ctx arguments
    default
      Models.call(name).create @collection, arguments

  get: ->
    factory 'Get', arguments

  set: ->
    factory 'Set', arguments

  delete: (context)->
    factory 'Delete', arguments
)

crud = (collection) ->
  new Models.Crud collection


crud('users').get(id).one
crud('users').get!.one(id)

users = crud('users')
users.get!.one(id)
users.get!.by(name: name).first
users.get!.by(name: name).all