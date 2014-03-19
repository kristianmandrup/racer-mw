Class       = require('jsclass/src/core').Class

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'

ConfigBuilder = new Class(
  initialize: (@name, @clazz, @multi-clazz) ->

  config: ->
    @builders[@name]   ||= new clazz @

    # create builder function
    @[name] = (...args) ->
      @builder(@name).build ...args

    @multi-config if @clazz-multi

  multi-config: ->
    plural = @name.pluralize!

    @builders[plural] ||= new @multi-clazz @

    @[plural] = (...args) ->
      @builder(plural).build ...args

  builder: (name) ->
    unless @builders[name]
      throw new Error "No builder '#{name}' registered for #{util.inspect @describe!}"
    @builders[name]
)

module.exports = ConfigBuilder