Module       = require('jsclass/src/core').Module

_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

PipeInspector = new Module(
  child-types: ->
    return "no children" unless @child-names!.length > 0
    self = @
    @child-names!.map (name) ->
      self.child(name).pipe-type

  describe-children: (recursive) ->
    return "no children" unless @child-names!.length > 0
    self = @
    @child-names!.map (name) ->
      self.child(name).describe recursive

  describe: (children) ->
    type: @pipe-type
    name: @name
    id: @id! if @id
    value: util.inspect @value!
    children: @children-display-value children

  children-display-value: (children) ->
    if children then @describe-children true else @child-names!.length
)

module.exports = PipeInspector