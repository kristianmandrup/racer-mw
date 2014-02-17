Class   = require('jsclass/src/core').Class
Module  = require('jsclass/src/core').Module
Hash    = require('jsclass/src/core').Hash

rek           = require 'rekuire'
requires      = rek 'requires'
lo            = require 'lodash'
_             = require 'prelude-ls'

racer = require 'racer'

middleware = require 'middleware'
Middleware = middleware.Middleware

# https://github.com/kristianmandrup/authorize-mw
authorize-mw = require('authorize-mw').AuthorizeMw

# https://github.com/kristianmandrup/validator-mw
validate-mw = require('validator-mw').ValidateMw

# https://github.com/kristianmandrup/decorator-mw
decorator-mw = require('decorator-mw').DecoratorMw

# https://github.com/kristianmandrup/marshaller-mw
decorator-mw = require('marshaller-mw').MarshallerMw

middlewares =
  authorize: authorize-mw
  validate: authorize-mw
  decorate: decorator-mw
  marshaller: marshaller-mw

# TODO: fix this!
store = racer.store

app ||= {}
app.model = store.createModel!

module.exports = new Class(
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
    @user ||= @model.get '_session.user'
 
  racer-middleware: ->
    @mw ||= new Middleware('model').use mw-stack!
 
  mw-stack: ->
    new Hash
 
  create-stack: (names) ->
    stack = {}
    names.each (name) ->
      stack[name] = middlewares[name]
    stack
 
  # hash
  stack: (mws) ->
    lo.extend @call-super, mws
 
  # TODO
  stack-before: (mws) ->

  document-path: void

  doc-path: ->
    @collection || @document-path

  item-path: ->
    @spath ||= @doc-path + '.' + @item
 

  # generator function to be used on some other query
  # should use currying!
  # test and improve this!
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