Module       = require('jsclass/src/core').Module

# requires  = require '../../../../requires'

_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

PipeInspector = new Module(
  child-types: ->
    @no-children! or @children!

  no-children: ->
    "no children" unless @has-children!

  children: ->
    lo.map @child-names, @child-type, @

  child-type: (name) ->
    @child(name).pipe-type

  describe-children: (recursive) ->
    @no-children! or @describe-child-list!

  describe-child-list: ->
    lo.map @child-names, @describe-child, @

  describe-child: (name) ->
    @child(name).describe recursive

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