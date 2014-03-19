Class       = require('jsclass/src/core').Class

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'

ConfigBuilder = new Class(
  initialize: (@pipe, @name, @clazzes = {}) ->
    @clazz       = @clazzes.clazz
    @multi-clazz = @clazzes.multi-clazz

    @validate-args!
    @builders = {}
    @

  validate-args: ->
    unless @name
      throw new Error "Must take a name as first argument"

    unless @clazz and _.is-type 'Function', @clazz
      throw new Error "Must take a constructor function (or class) as seconds argument, was: #{@clazz}"

  config: ->
    @single-config!
    @multi-config!
    @builders

  single-config: ->
    return unless @clazz

    @builders[@name]   ||= new @clazz @pipe

    # create builder function
    @[@name] = (...args) ->
      @builder(@name).build ...args
    @

  multi-config: ->
    return unless @multi-clazz

    plural = @name.pluralize!

    @builders[plural] ||= new @multi-clazz @pipe

    @[plural] = (...args) ->
      @builder(plural).build ...args
    @

  builder: (name) ->
    @builders[name]
)

module.exports = ConfigBuilder