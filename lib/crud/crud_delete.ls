Class       = require('jsclass/src/core').Class
Module      = require('jsclass/src/core').Module
Hash        = require('jsclass/src/core').Hash

rek         = require 'rekuire'
requires    = rek 'requires'
lo          = require 'lodash'
_           = require 'prelude-ls'

RacerSync   = requires.crud 'racer_sync'

module.exports = new Class(RacerSync,
  initialize: (@context) ->
    @call-super!
    @getter = new Models.Get @context
 
  extend:
    create: (collection, ids) ->
      new @ collection: collection, ids: ids
 
  # validation not needed on delete!
  mw-stack: ->
    @create-stack 'authorize-mw', 'racer-mw'

  # obj = model.del ( path, [callback] )
  # Returns the deleted object
  one: (cb) ->
    @perform 'del', @getter.one!, cb
 
  # delete array
  selected: ->
    selection @getter.selected!
 
  selection: (list) ->
    list.each (item) ->
      @one item._id
)