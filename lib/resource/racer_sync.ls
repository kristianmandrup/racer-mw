Class   = require('jsclass/src/core').Class
Module  = require('jsclass/src/core').Module
Hash    = require('jsclass/src/core').Hash

requires      = require '../../requires'
lo            = require 'lodash'
_             = require 'prelude-ls'

racer         = require 'racer'

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

# TODO: Split into modules/classes and use include ??
# Not all Crud classes need all this. Must be possible to select pieces to assemble for each!
module.exports = new Class(
  initialize: (@context) ->
    unless _.is-type 'Object', @context
      throw Error "Context object must be a Hash, was: #{@context}"
    @model  = @context.model

  current-user: ->
    # the model of the session user
    @user ||= @model.get '_session.user'
 
  racer-middleware: ->
    @mw ||= new Middleware('model').use mw-stack!
 
  mw-stack: ->
    {}
 
  create-stack: (names) ->
    stack = {}
    names.each (name) ->
      stack[name] = middlewares[name]
    stack

  # mws : hash
  stack: (mws) ->
    lo.extend @call-super, mws

  exec: (args) ->
    @racer-middleware.run args
)