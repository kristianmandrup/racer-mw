Class       = require('jsclass/src/core').Class
Module      = require('jsclass/src/core').Module
Hash        = require('jsclass/src/core').Hash

rek         = require 'rekuire'
requires    = rek 'requires'
lo          = require 'lodash'
_           = require 'prelude-ls'

RacerSync   = requires.crud 'racer_sync'

module.exports = new Class(RacerSync,
  extend:
    create: (collection, items) ->
      new @ collection: collection, items: items
 
  # marshal-mw
  # filters any local data that should not be stored (depending on context)
  # similar to decorator
  # should be used after validation before racer-mw
  mw-stack: ->
    @create-stack 'authorize-mw', 'validate-mw', 'marshal-mw', 'racer-mw'
 
  one: ->
    @perform 'set', @item
 
  # should be generator function to be used on
  own: (fun, key) ->
    @my-own(@[fun], @item)
 
  # push array
  many: ->
    @perform 'set', @items
)