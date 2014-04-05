Class     = require('jsclass/src/core').Class
get       = require '../../../requires' .get!
_         = require 'prelude-ls'
lo        = require 'lodash'

# A Pipe can have one parent but many children. Pipes can thus be made into a tree.
# Each pipe reflect the type of object at that particular position in the model, thus
# it can act as a complete abstraction layer over the model.

modules = {}
helpers = {}

clazz-name = (name) ->
  "Pipe#{name.camelize!}"

require-module = (name) ->
  modules[clazz-name name] = get.base-module name.underscore!

base-modules = <[clean-slate describer identifier resource setter validation value]>

lo.each base-modules, require-module

BasePipe = new Class(
  include: _.values(modules)

  # if not initialized with a value it has nothing to calculate path from
  initialize: (...args) ->
    @call-super!
    @post-init!
    @

  type:       'Pipe'
  info:
    type:       'Base'
    base-type:  'Base'

  # last step when pipe is initialized
  # override in modules...
  post-init: ->
    @call-super!
)

# TODO - add builders to prototype
# config-builders!

BasePipe.prototype <<< _.values modules

module.exports = BasePipe
