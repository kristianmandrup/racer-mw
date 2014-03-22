Class       = require('jsclass/src/core').Class

requires = require '../../../requires'

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'

BuilderConfigurator = requires.pipe 'builder/builder_configurator'

ConfigBuilder = new Class(
  initialize: (@pipe, @name, @clazzes = {}) ->
    @clazz       = @clazzes.clazz
    @plural-clazz = @clazzes.plural-clazz

    @validate-args!
    @builders = {}
    @

  validate-args: ->
    unless _.is-type 'Object', @pipe
      throw new Error "Pipe must be an Object, was: #{@pipe}"

    unless @pipe.type is 'Pipe'
      throw new Error "Pipe must be a type: Pipe, was: #{@pipe.type}"

    unless @name
      throw new Error "Must take a name as first argument"

    unless @clazz and _.is-type 'Function', @clazz
      throw new Error "Must take a constructor function (or class) as seconds argument, was: #{@clazz}"

  config: ->
    @single-config!
    @plural-config!
    @builders

  single-config: ->
    new BuilderConfigurator(@name.pluralize!, @, @plural-clazz).configure!

  plural-config: ->
    new BuilderConfigurator(@name, @, @clazz).configure!

  builder: (name) ->
    @builders[name]
)

module.exports = ConfigBuilder