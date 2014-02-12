Class   = require('jsclass/src/core').Class
Module  = require('jsclass/src/core').Module
Hash    = require('jsclass/src/core').Hash

_ = require 'prelude-ls'

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
 
  one: ->
    @perform 'del', @getter.one!
 
  # delete array
  selected: ->
    selection @getter.selected!
 
  selection: (list) ->
    list.each (item) ->
      @one item._id
 
  all: ->
    @model.destroy!
)