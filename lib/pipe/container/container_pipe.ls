Module      = require('jsclass/src/core').Module
get         = require '../../../requires' .get!
BasePipe    = get.apipe 'base'

# TODO: Perhaps rename to ParentPipe ??
ContainerPipe = new Module(
  initialize: (...args) ->
    @call-super!
    @

  # TODO: Should be set dynamically, only overwrite value if void!
  pipe:
    type:       'Container'
    container:  true
    child:      void
    named:      void
    kind:       'Container'

  allows-child: (type) ->
    type in @valid-children

  add: (...args) ->
    @adder.add args

  adder: ->
    @_adder ||= new PipeAddHelper @
)

module.exports = ContainerPipe
