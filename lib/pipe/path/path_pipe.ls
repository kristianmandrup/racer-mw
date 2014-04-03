Class       = require('jsclass/src/core').Class

get = require '../../../requires' .get!

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

BasePipe          = get.apipe 'base'

# Is a kind of model
PathPipe = new Class(BasePipe,
  include:
    * ModelPipe
    ...

  initialize: ->
    @call-super!
    @

  pipe:
    type:       'Path'
    base-type:  'Path'

  has-resource: false

  valid-parents:
    * \path

  valid-children:
    kind: \named
)

module.exports = PathPipe