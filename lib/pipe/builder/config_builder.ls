Class       = require('jsclass/src/core').Class

requires = require '../../../requires'

require 'sugar'

BuilderConfigurator = requires.pipe 'builder/builder_configurator'
PipeValidation      = requires.pipe 'pipe_validation'

ConfigBuilder = new Class(
  include:
    * PipeValidation
    ...

  initialize: (@pipe, @name) ->
    @validate-args!
    @builders = {}
    @

  validate-args: ->
    @is-pipe @pipe

    unless @name
      throw new Error "Must take a name as first argument"

  config: ->
    @single-config!
    @plural-config!
    @builders

  plural-config: ->
    new BuilderConfigurator(@name.pluralize!, @).configure!

  single-config: ->
    new BuilderConfigurator(@name, @).configure!

  builder: (name) ->
   @builders[name]
)

module.exports = ConfigBuilder