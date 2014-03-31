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
PipeValidation  = requires.pipe 'pipe_validation'
Parser          = requires.pipe 'pipe_parser'

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
    * PipeValidation
    * PipeArgValidation

  # if not initialized with a value it has nothing to calculate path from
  initialize: ->
    # TODO: Refactor - improve this way! use slice or similar instead!!
    [@first-arg, @args] = argumentor.extract _.values(arguments)
    @validate-args! # See PipeArgValidation
    @call-super!
    @clear!
    @

  # since not a container pipe!
  allows-child: (type) ->
    false

  pipes: (args) ->
    throw new Error "Only a Container pipe has parsed pipes, I am a #{@pipe.type} pipe"

  parse: (...args) ->
    throw new Error "Only a Container pipe can parse pipes, I am a #{@pipe.type} pipe"

  add: (...args) ->
    throw new Error "Only Container pipes can add pipes, I am a #{@pipe.type} pipe"

  type:       'Pipe'
  pipe:
    type:       'Base'
    base-type:  'Base'

  valid-args:     []
  valid-children: []
  valid-parents:  []

  set-all: ->

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
