Class   = require('jsclass/src/core').Class
get     = require '../../../../requires' .get!
_       = require 'prelude-ls'

CollectionPipe    = requires.apipe 'collection'
BasePipeBuilder   = requires.container-builder 'base'

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