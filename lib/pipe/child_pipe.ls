Class       = require('jsclass/src/core').Class
get         = require '../../requires' .get!
BasePipe    = get.apipe 'base'

ChildPipe = new Class(BasePipe,
  initialize: (...args) ->
    @call-super!
    @

  pipe:
    type:       'Child'
    base-type:  'Child'

  # since not a container pipe!
  allows-child: (type) ->
    false

  pipes:  ->
    @api-error 'has parsed pipes'

  parse: ->
    @api-error 'can parse pipes'

  add: ->
    @api-error 'can add pipes'

  parser: ->
    @api-error 'has a parser'

  api-error-msg: (reason) ->
    throw new Error  "Only a Container pipe #{reason}, I am a #{@pipe.type} pipe"

)

module.exports = ChildPipe
