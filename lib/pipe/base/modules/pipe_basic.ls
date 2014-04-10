Module    = require('jsclass/src/core').Module
get       = require '../../../../requires' .get!
_         = require 'prelude-ls'
lo        = require 'lodash'

# A Pipe can have one parent but many children. Pipes can thus be made into a tree.
# Each pipe reflect the type of object at that particular position in the model, thus
# it can act as a complete abstraction layer over the model.

modules = {}

clazz-name = (name) ->
  "Pipe#{name.camelize!}"

require-module = (name) ->
  modules[clazz-name name] = get.base-module name.underscore!

base-modules = <[clean-slate describer setter]>

lo.each base-modules, require-module

basic-modules = _.values(modules)

PipeBasic = new Module(
  include: basic-modules

  initialize: (...args) ->
    @call-super!
)

module.exports = PipeBasic