Module       = require('jsclass/src/core').Module

requires  = require '../../requires'

_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'


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

  config-builder: (name, clazz, clazz-multi = void) ->
    if @valid-child name
      @builders[name]   ||= new clazz @

      # create builder function
      @[name] = (...args) ->
        @builder(name).build ...args

      if clazz-multi
        plural = name.pluralize!

        @builders[plural] ||= new clazz-multi @

        @[plural] = (...args) ->
          @builder(plural).build ...args

  builder: (name) ->
    unless @builders[name]
      throw new Error "No builder #{name} registered for #{util.inspect @describe!}"
    @builders[name]
)

module.exports = PipeBuilders