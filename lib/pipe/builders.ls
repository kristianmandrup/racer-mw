Module       = require('jsclass/src/core').Module

requires  = require '../../requires'

_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

ConfigBuilder    = requires.apipe-builder 'config'

PipeBuilders = new Module(
  initialize: ->

  config-builders: ->
    return void unless @attach
    @builders ||= {}

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
    return unless @valid-child @name
    new ConfigBuilder(name, clazz, multi-clazz).config!

)

module.exports = PipeBuilders