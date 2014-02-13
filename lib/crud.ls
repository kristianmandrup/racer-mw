Class       = require('jsclass/src/core').Class
Module      = require('jsclass/src/core').Module
Hash        = require('jsclass/src/core').Hash

rek         = require 'rekuire'
requires    = rek 'requires'
lo          = require 'lodash'
_           = require 'prelude-ls'

crud =
  Get:    requires.crud 'crud_get'
  Set:    requires.crud 'crud_set'
  Delete: requires.crud 'crud_delete'

module.exports = new Class(
  initialize (@collection) ->
    @model = app.model
 
  extend:
    create: (args) ->
      # new @
 
  ctx: (ctx) ->
    lo.extend {collection: @collection}, ctx
 
  factory: ->
    name = arguments.first
    switch typeof arguments
    case 'object'
      new crud[name] @ctx(arguments)
    default
      crud[name].create @collection, arguments
 
  get: ->
    factory 'Get', arguments
 
  set: ->
    factory 'Set', arguments
 
  delete: ->
    factory 'Delete', arguments
)
