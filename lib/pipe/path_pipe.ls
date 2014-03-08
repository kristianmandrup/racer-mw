Class       = require('jsclass/src/core').Class

requires = require '../../requires'

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

BasePipe          = requires.apipe 'base'

unpack = (args) ->
    switch typeof! args
    case 'Array'
      args.join '.'
    case 'String'
      args
    case 'Function'
      args!
    default
      throw new Error "Invalid name argument(s) for PathPipe: #{@args}"

# Must be on a model or attribute
# Useful to set initial model path containers such as '_session' or '_page' etc.
PathPipe = new Class(BasePipe,
  initialize: ->
    @call-super!
    @name = unpack @args
    @post-init!
    @

  attribute: (...args) ->
    @builder('attribute').build ...args

  model: (...args) ->
    @builder('model').build ...args

  collection: (...args) ->
    @builder('collection').build ...args

  pipe-type: 'Path'

  has-resource: false

  id: ->
    @name

  valid-args:
    * 'string'

  valid-parents:
    * 'path'
)

module.exports = PathPipe