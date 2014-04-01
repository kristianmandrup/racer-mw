Class       = require('jsclass/src/core').Class

requires  = require '../../requires'

ChildPipe = new Class(BasePipe,
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

module.exports = ContainerPipe
