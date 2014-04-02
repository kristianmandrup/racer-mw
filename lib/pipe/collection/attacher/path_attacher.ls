Module = require('jsclass/src/core').Module

requires = require '../../../requires'

PathPipe = requires.apipe 'path'

CollectionPathAttacher = new Module(
  # See TestCase!
  attach-to-path-pipe: (names) ->
    path-pipe = new PathPipe(names)
    path-pipe.attach @

  config-via-array: ->
    @attach-to-path-pipe @args[0 to -2] # WTF!?
    @args.last!
)

module.exports = CollectionPathAttacher