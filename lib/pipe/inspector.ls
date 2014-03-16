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

  child-names: ->
    _.keys @children

  describe-children: ->
    return "no children" unless @child-names!.length > 0
    self = @
    @child-names!.map (name) ->
      self.child(name).describe!

  describe: (children) ->
    base =
      type: @pipe-type
      name: @name
      id: @id! if @id
      value: @value
      children: @child-names!.length
    if children then lo.extend(base, children: @describe-children!) else base
)

module.exports = PipeInspector