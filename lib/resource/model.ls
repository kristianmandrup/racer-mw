Class       = require('jsclass/src/core').Class

requires    = require '../../requires'

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

BaseResource   = requires.resource 'base'
Filtering      = requires.resource 'filtering'

ModelResource = new Class(BaseResource,
  # value-object
  initialize: (args) ->
    lo.extend @commands, @model-commands, Filtering.commands
    @call-super @
    @

  model-commands:
    on-scope:
      * 'get'
    set-scope:
      * 'set'
      * 'set-null'
      * 'set-diff'
      * 'del'
      * 'ref'
      * 'remove-ref'
)

module.exports = ModelResource