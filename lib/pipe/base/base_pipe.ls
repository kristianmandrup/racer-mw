Class     = require('jsclass/src/core').Class

get       = require '../../../requires' .get!

_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

# A Pipe can have one parent but many children. Pipes can thus be made into a tree.
# Each pipe reflect the type of object at that particular position in the model, thus
# it can act as a complete abstraction layer over the model.

modules = {}
helpers = {}

clazz-name = (name) ->
  "Pipe#{name.camelize!}"

require-module = (name) ->
  modules[clazz-name name] = get.base-module name.underscore!

require-helper = (name) ->
  helpers[clazz-name name] = get.base "pipe_#{name.underscore!}"

base-modules = <[arg_validation attacher builders family identifier inspector resource validation value]>
base-helpers = <[navigator parser argumentor]>

lo.each base-modules, require-module
lo.each base-helpers, require-helper

BasePipe = new Class(
  include: _.values(modules)

  # if not initialized with a value it has nothing to calculate path from
  initialize: (...args) ->
    # TODO: Use name and value extractors
    # @validate-args! # See PipeArgValidation
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

  parent-name: ->
    if @parent then @parent.full-name else ''

  clear: ->
    @child-hash = {}
    @update-child-count!
    @
)

module.exports = BasePipe
