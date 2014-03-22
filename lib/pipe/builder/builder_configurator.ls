Class       = require('jsclass/src/core').Class

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'

requires = require '../../../requires'

BuilderConfigurator = new Class(
  initialize: (@name, @config) ->
    @pipe          = @config.pipe
    @builders      = @config.builders
    @builder-clazz = requires.apipe-builder(@name.to-lower-case!)
    @

  configure: ->
    @builders[@name] ||= @create-builder!

    # create builder function on pipe
    @pipe[@name] = @builder-fun!
    @

  create-builder: ->
    new @builder-clazz @pipe

  builder-fun: ->
    self = @
    (...args) ->
      # context is pipe
      b = @builder(self.name)
      unless lo.is-empty args then b.build(...args) else b
)

module.exports = BuilderConfigurator