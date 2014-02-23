Class       = require('jsclass/src/core').Class
requires    = require '../../requires'

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

BaseResource   = requires.resource 'base'
Filtering      = requires.resource 'filtering'

CollectionResource = new Class(BaseResource,
  # value-object
  initialize: (args) ->
    lo.extend @commands, @col-commands, Filtering.commands
    @call-super @
    @

  col-commands:
    on-scope: # always on scope
      * 'get'
    set-scope:
      * 'set'
      * 'set-null'
      * 'set-diff'
      * 'del'
      * 'add'
      * 'push'
      * 'unshift'
      * 'insert'
      * 'pop'
      * 'shift'
      * 'remove'
      * 'move'
      * 'ref-list'
      * 'remove-ref-list'
)

module.exports = CollectionResource
