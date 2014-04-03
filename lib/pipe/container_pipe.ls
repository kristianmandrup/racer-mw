Class       = require('jsclass/src/core').Class
get         = require '../../requires' .get!
BasePipe    = get.apipe 'base'

ContainerPipe = new Class(BasePipe,
  initialize: (...args) ->
    @call-super!
    @

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
