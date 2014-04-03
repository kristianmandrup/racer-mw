Module       = require('jsclass/src/core').Module

requires  = require '../../../../requires'
get       = requires.get!

_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

ConfigBuilder    = get.pipe-builder 'config'

PipeBuilders = new Module(
  initialize: ->
    @builders = {}
    @

  config-builders: ->
    lo.each @builder-list, @config-builder, @

  builder-list: <[collection model attribute]>

  # used by generated builder functions (see ConfigBuilder)
  builder: (name) ->
    unless @builders[name]
      throw new Error "No builder '#{name}' registered for #{util.inspect @describe!}, only: #{@builder-names!}"
    @builders[name]

  builder-names: ->
    _.keys @builders

)

module.exports = PipeBuilders