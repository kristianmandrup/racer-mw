Class       = require('jsclass/src/core').Class
Module      = require('jsclass/src/core').Module
Hash        = require('jsclass/src/core').Hash

rek         = require 'rekuire'
requires    = rek 'requires'
lo          = require 'lodash'
_           = require 'prelude-ls'

RacerSync   = requires.crud 'racer_sync'
Getter      = requires.crud('crud/utils').Getter

module.exports = new Class(RacerSync,
  include: Getter
 
  extend:
    create: (collection, ids) ->
      new @ collection: collection, ids: ids
 
  # validation not needed
  # must decorate loaded model
  mw-stack: ->
    @create-stack 'authorize-mw', 'racer-mw', 'decorate-mw'
    
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