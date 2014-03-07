Class       = require('jsclass/src/core').Class

requires    = require '../../../requires'

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'

PipeBuilder       = requires.pipe 'builder'
CollectionPipe    = requires.pipe 'attribute'

PipeBuilder       = requires.pipe 'builder'

# TODO: Wrap in a class!
CollectionBuilder = new Class(PipeBuilder,
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

module.exports = CollectionBuilder