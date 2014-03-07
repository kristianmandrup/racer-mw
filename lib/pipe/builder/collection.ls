Class       = require('jsclass/src/core').Class

requires    = require '../../../requires'

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'

PipeBuilder       = requires.pipe 'builder'
CollectionPipe    = requires.pipe 'collection'

BasePipeBuilder   = requires.pipe-builder 'base'

CollectionPipeBuilder = new Class(BasePipeBuilder,
  build: ->
    args = _.values(arguments)
    switch args.length
    case 0
      throw new Error "Must take at least one argument to indicate the collection to add"
    case 1
     collection = new CollectionPipe args.first!
     @attach collection
     collection
    default
      throw new Error "Too many arguments, takes only a name (String), or an Object"
)

module.exports = CollectionPipeBuilder