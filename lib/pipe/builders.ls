Module       = require('jsclass/src/core').Module

requires  = require '../../requires'

_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

ConfigBuilder    = requires.apipe-builder 'config'

PipeBuilders = new Module(
  initialize: ->

  # TODO: Needs refactoring!!! Single Responsibility pleeeease...
  config-builders: ->
    return void unless @attach
    @builders = {}

    # TODO: refactor - put in initialize...
    if @valid-children
      @valid-children = [@valid-children].flatten!
    if @valid-parents
      @valid-parents = [@valid-parents].flatten!

    CollectionPipeBuilder   = requires.apipe-builder 'collection'
    ModelPipeBuilder        = requires.apipe-builder 'model'
    AttributePipeBuilder    = requires.apipe-builder 'attribute'

    CollectionsPipeBuilder  = requires.apipe-builder 'collections'
    ModelsPipeBuilder       = requires.apipe-builder 'models'
    AttributesPipeBuilder   = requires.apipe-builder 'attributes'

    @config-builder 'collection', CollectionPipeBuilder, CollectionsPipeBuilder
    @config-builder 'model', ModelPipeBuilder, ModelsPipeBuilder
    @config-builder 'attribute', AttributePipeBuilder, AttributesPipeBuilder
    @

  config-builder: (name, clazz, multi-clazz) ->
    return unless @valid-child name
    builders = new ConfigBuilder(@, name, clazz: clazz, multi-clazz: multi-clazz).config!
    lo.extend @builders, builders

  valid-child: (name) ->
    return false if @valid-children is void or @valid-children is []
    name in @valid-children

  # used by generated builder functions (see ConfigBuilder)
  builder: (name) ->
    unless @builders[name]
      throw new Error "No builder '#{name}' registered for #{util.inspect @describe!}, only: #{@builder-names!}"
    @builders[name]

  builder-names: ->
    _.keys @builders

)

module.exports = PipeBuilders