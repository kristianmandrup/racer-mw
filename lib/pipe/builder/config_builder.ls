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
    name = @name

    # create builder function on pipe
    @pipe[name] = (...args) ->
      b = @builder(name)
      unless lo.is-empty args then b.build(...args) else b
    @

  multi-config: ->
    return unless @multi-clazz

    plural = @name.pluralize!

    @builders[plural] ||= new @multi-clazz @pipe

    # create builder function on pipe
    @pipe[plural] = (...args) ->
      b = @builder(plural)
      unless lo.is-empty args then b.build(...args) else b
    @

  builder: (name) ->
    @builders[name]
)

module.exports = ConfigBuilder