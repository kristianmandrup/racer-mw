Class       = require('jsclass/src/core').Class

requires  = require '../../requires'

_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

# A Pipe can have one parent but many children. Pipes can thus be made into a tree.
# Each pipe reflect the type of object at that particular position in the model, thus
# it can act as a complete abstraction layer over the model.

self = @
require-module = (name) ->
  self["Pipe#{name.camelize!}"] = requires.pipe!base!modules!file "pipe_#{name.underscore!}"

require-helper = (name) ->
  self["Pipe#{name.camelize!}"] = requires.pipe!base!file "pipe_#{name.underscore!}"

base-modules = <[builders attacher inspector family value identifier resource validation]>
base-helpers = <[navigator parser argumentor]]>

lo.each base-modules, require-module
lo.each base-helpers, require-helper

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
