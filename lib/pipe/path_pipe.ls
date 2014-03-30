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

PipeBuilders = new Module(
  initialize: ->
    lo.each @valid-children, @create-builder

  build: (pipe-type, ...args) ->
    @builder(pipe-type).build ...args

  create-builder: (name) ->
    @[name] = (...args) ->
      @build name ...args

)


# Must be on a model or attribute
# Useful to set initial model path containers such as '_session' or '_page' etc.
PathPipe = new Class(BasePipe,
  include:
    * PipeBuilders
    ...

  initialize: ->
    @call-super!
    @name = unpack @args
    @post-init!
    @

  pipe-type: 'Path'

  has-resource: false

  id: ->
    @name

  valid-args:
    * \string

  valid-parents:
    * \path

  valid-children:
    * \attribute
    * \model
    * \collection
)

module.exports = PathPipe