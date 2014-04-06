Module    = require('jsclass/src/core').Module
get       = require '../../../requires' .get!

BasePipe  = get.apipe 'base'

ChildPipe = new Module(
  initialize: (...args) ->
    @call-super!
    @

  # TODO: Should be set dynamically, only overwrite value if void!
  pipe:
    type:       'Child'
    container:  false
    child:      true
    named:      void
    kind:       'Child'

  # since not a container pipe!
  allows-child: (type) ->
    false

  pre-attach-to: (parent) ->
    @call-super!
    @attacher!.attach-to parent

  attacher: ->
    new ParentAttacher @

  pipes:  ->
    @api-error 'has parsed pipes'

  parse: ->
    @api-error 'can parse pipes'

  add: ->
    @api-error 'can add pipes'

  parser: ->
    @api-error 'has a parser'

  api-error-msg: (reason) ->
    throw new Error  "Only a Container pipe #{reason}, is #{@pipe.type} pipe"

)

module.exports = ChildPipe
