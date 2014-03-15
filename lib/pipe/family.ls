/**
 * User: kmandrup
 * Date: 08/03/14
 * Time: 16:46
 */
Module       = require('jsclass/src/core').Module

requires  = require '../../requires'

_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

PipeFamily = new Module(
  initialize: ->
    @clear!

  ancestors: ->
    my-ancestors = []
    if @parent
      my-ancestors.push @parent
      my-ancestors.push @parent.ancestors! if @parent.ancestors
    my-ancestors.flatten!.compact!

  child: (name) ->
    @children[name]

  valid-child: (name) ->
    return false if @valid-children is void or @valid-children is []
    name in @valid-children

  parent-name: ->
    if @parent then @parent.full-name else ''

  # subclass should override!
  valid-parents: []
  parent: void
  children:   {}

  clear: ->
    @children = {}
    @
)

module.exports = PipeFamily
