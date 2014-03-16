Class       = require('jsclass/src/core').Class

requires  = require '../../requires'

_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

# A Pipe can have one parent but many children. Pipes can thus be made into a tree.
# Each pipe reflect the type of object at that particular position in the model, thus
# it can act as a complete abstraction layer over the model.

PipeBuilders    = requires.pipe 'builders'
PipeAttacher    = requires.pipe 'attacher'
PipeInspector   = requires.pipe 'inspector'
PipeNavigator   = requires.pipe 'navigator'
PipeFamily      = requires.pipe 'family'
PipeValue       = requires.pipe 'value'
PipeIdentifier  = requires.pipe 'identifier'
PipeResource    = requires.pipe 'resource'

argumentor      = requires.pipe 'argumentor'

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
    unless argumentor.validate @args, @valid-args
      throw new Error "Pipe init argument #{@args} [#{typeof @args}] is not valid, must be one of: #{@valid-args}"
    @call-super!
    @clear!
    @

  parse: (obj) ->
    try
      Parser  = requires.pipe 'parser'
      pipes   = new Parser(obj).parse!
      @attach pipes
      @
    finally
      @

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
