Class       = require('jsclass/src/core').Class

requires  = require '../../requires'

_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

# A Pipe can have one parent but many children. Pipes can thus be made into a tree.
# Each pipe reflect the type of object at that particular position in the model, thus
# it can act as a complete abstraction layer over the model.

PipeBuilders    = requires.pipe 'pipe_builders'
PipeAttacher    = requires.pipe 'pipe_attacher'
PipeInspector   = requires.pipe 'pipe_inspector'
PipeNavigator   = requires.pipe 'pipe_navigator'
PipeFamily      = requires.pipe 'pipe_family'
PipeValue       = requires.pipe 'pipe_value'
PipeIdentifier  = requires.pipe 'pipe_identifier'
PipeResource    = requires.pipe 'pipe_resource'
argumentor      = requires.pipe 'pipe_argumentor'

BasePipe = new Class(
  include:
    * PipeBuilders
    * PipeAttacher
    * PipeInspector
    * PipeNavigator
    * PipeFamily
    * PipeValue
    * PipeIdentifier
    * PipeResource

  # if not initialized with a value it has nothing to calculate path from
  initialize: ->
    [@first-arg, @args] = argumentor.extract _.values(arguments)

    @validate-first-arg!
    unless argumentor.validate @args, @valid-args
      throw new Error "Pipe init argument #{@args} [#{typeof @args}] is not valid, must be one of: #{@valid-args}"
    @call-super!
    @clear!
    @

  validate-first-arg: ->
    switch typeof! @first-arg
    case 'Number'
      throw new Error "First arg can not be a Number, was: #{@first-arg}"
    case 'Function'
      throw new Error "First arg can not be a Function"


  parse: (...args) ->
    try
      Parser  = requires.pipe 'pipe_parser'
      pipes   = new Parser(...args).parse!
      @attach pipes
      @
    finally
      @

  add: (...args) ->
    @parse ...args

  type:       'Pipe'
  pipe-type:  'Base'

  valid-args: []

  # last step when pipe is initialized
  post-init: ->
    @cleanup!
    @create-res!
    @config-builders!
    @post-build!

  cleanup: ->
    delete @args
    delete @first-arg

  post-build: ->
)

module.exports = BasePipe
