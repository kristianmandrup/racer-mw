Class       = require('jsclass/src/core').Class

requires  = require '../../requires'

ContainerPipe = new Class(BasePipe,
  initialize: ->
    @call-super!
    @set-all!
    @post-init!
    @

  set-all: ->
    @call-super!

  post-init: ->
    @call-super!

  pipe:
    type:       'Container'
    base-type:  'Container'

  allows-child: (type) ->
    type in @valid-children

  add: (...args) ->
    @parse ...args

  parse: (...args) ->
    @attach @pipes(args)

  pipes: (args) ->
    @parser(args).parse!

  parser: (args) ->
    new Parser(args)
)

module.exports = ContainerPipe
