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

  # previous = model.set ( path, value, [callback] )
  value: ->
   @perform 'set', value

  # model.setEach ( path, object, [callback] )
  each: (value) ->
    @perform 'setEach', value

  # obj = model.setNull ( path, value, [callback] )
  if-null: (value) ->
    @perform 'setNull', value

  # model.setDiff ( path, value, [options], [callback] )
  diff: -> (path, value, opts) ->
    if opts and typeof opts is 'object'
      options   = opts['options']
      callback  = opts['cb']

    @perform 'setDiff' value, options, callback

  # num = model.increment ( path, [byNum], [callback] )
  increment: (by-num, cb) ->
    @perform 'increment', byNum, cb

  # id = model.add ( path, object, [callback] )
  add: (obj, cb) ->
    @perform 'add', obj, cb

)