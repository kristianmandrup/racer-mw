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

    @config-builder 'collection'
    @config-builder 'model'
    @config-builder 'attribute'
    @

  config-builder: (name, clazz, multi-clazz) ->
    return unless @valid-child name
    @config-parser name

    builders = new ConfigBuilder(@, name).config!
    lo.extend @builders, builders

  config-parser: (name) ->
    fun = (...args) ->
      @[name]!.parse ...args

    alias =
      attributes: 'attrs'
      collections: 'cols'
      models: 'modls'

    @["parse-#{name}"] = fun
    @["parse-#{alias[name]}"] = fun if alias[name]

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