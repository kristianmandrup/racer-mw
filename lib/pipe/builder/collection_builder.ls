Class       = require('jsclass/src/core').Class

requires    = require '../../../requires'

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'


CollectionPipe    = requires.apipe 'collection'
BasePipeBuilder   = requires.apipe-builder 'base'

CollectionPipeBuilder = new Class(BasePipeBuilder,
  initialize: (@container) ->
    @call-super!
    @

  type: 'Builder'
  builder-type: 'Collection'

  build: ->
    args = _.values(arguments)
    switch args.length
    case 0
      throw new Error "Must take at least one argument to indicate the collection to add"
    case 1
     name = args.first!
     @create-collection name
    default
      throw new Error "Too many arguments, takes only a name (String), or an Object"

  create-collection: (name) ->
     collection = new CollectionPipe name
     @attach collection
     collection

)

module.exports = CollectionPipeBuilder