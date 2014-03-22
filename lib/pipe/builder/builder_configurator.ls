Class       = require('jsclass/src/core').Class

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'


BuilderConfigurator = new Class(
  initialize: (@name, @config, @clazz) ->
    @pipe       = @config.pipe
    @builders   = @config.builders
    @

  configure: ->
    return unless @clazz

    @builders[@name] ||= new @clazz @pipe

    # create builder function on pipe
    @pipe[@name] = @builder-fun!
    @

  builder-fun: ->
    (...args) ->
      # context is pipe
      b = @builder(@name)
      unless lo.is-empty args then b.build(...args) else b
)

module.exports = BuilderConfigurator