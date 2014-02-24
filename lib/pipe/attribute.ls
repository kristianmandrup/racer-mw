Class       = require('jsclass/src/core').Class

requires = require '../../requires'

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

BasePipe          = requires.pipe 'base'

# Must be on a model
AttributePipe = new Class(BasePipe,
  initialize: (@parent, @name) ->
    @validate!
    @call-super @name

  # does this make sense?
  model: ->
    switch arguments.length
    case 0
      throw new Error "Must take a name, a value (object) or a {name: value} as an argument"
    case 1
     @_add-model arguments[0]
    default
      throw new Error "Too many arguments, takes only a name, a value (object) or a {name: value}"

  # does this make sense?
  collection: ->
    switch arguments.length
    case 0
      throw new Error "Must take a name, a value (object) or a {name: value} as an argument"
    case 1
     @_add-model arguments[0]
    default
      throw new Error "Too many arguments, takes only a name, a value (object) or a {name: value}"
)

module.exports = AttributePipe