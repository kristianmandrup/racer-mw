Class       = require('jsclass/src/core').Class

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'

ConfigBuilder = new Class(
  initialize: (@name, @clazz, @multi-clazz = void) ->
    @validate-args!
    @builders = {}
    @

  validate-args: ->
    unless @name
      throw new Error "Must take a name as first argument"

    unless @clazz and _.is-type 'Function', @clazz
      throw new Error "Must take a constructor function (or class) as seconds argument, was: #{@clazz}"

  config: ->
    @builders[@name]   ||= new clazz @

    # create builder function
    @[name] = (...args) ->
      @builder(@name).build ...args

    @multi-config if @clazz-multi
    @builders

  multi-config: ->
    plural = @name.pluralize!

    @builders[plural] ||= new @multi-clazz @

    @[plural] = (...args) ->
      @builder(plural).build ...args
)

module.exports = ConfigBuilder