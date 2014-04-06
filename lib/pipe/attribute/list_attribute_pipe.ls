Class       = require('jsclass/src/core').Class

get   = require '../../../requires' .get!

AttributePipe  = get.apipe 'attribute'

# Must be on a model or path pipe
ListAttributePipe = new Class(AttributePipe,
  initialize: (...@args) ->
    @call-super!

  info:
    value-type: 'array' # Signals use of ArrayValueObject and Array Value extract
)

module.exports = ListAttributePipe
