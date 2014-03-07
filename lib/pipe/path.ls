Class       = require('jsclass/src/core').Class

requires = require '../../requires'

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

BasePipe          = requires.pipe 'base'

# Must be on a model or attribute
# Useful to set initial model path containers such as '_session' or '_page' etc.
PathPipe = new Class(BasePipe,
  initialize: ->
    @call-super!

    switch typeof! @args
    case 'Array'
      @name = @args.join '.'
    case 'String'
      @name = @args
    case 'Function'
      @name = @args!
    default
      throw new Error "Invalid name argument(s) for PathPipe: #{@args}"

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