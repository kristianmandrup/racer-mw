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

  has-children: true

  ancestors: ->
    my-ancestors = []
    if @parent
      my-ancestors.push @parent
      my-ancestors.push @parent.ancestors! if @parent.ancestors
    my-ancestors.flatten!.compact!

  child: (name) ->
    @child-hash[name]

  remove-child: (name) ->
    removed = lo.extend {}, @child-hash[name]
    removed.parent = void
    delete @child-hash[name]
    @update-child-count!
    removed

  add-child: (name, pipe) ->
    unless _.is-type 'String', name
      throw new Error "Name of pipe added must be a String, was: #{name}"

    unless _.is-type 'Object', pipe
      throw new Error "Pipe added as child must be an Object, was: #{pipe}"

    unless @has-children
      throw new Error "This pipe does not allow child pipes"

    pipe.parent = @
    @child-hash[name] = pipe
    @update-child-count!

  update-child-count: ->
    @child-count = @child-names!.length

  child-count: 0

  child-list: ->
    _.values(@child-hash).compact!

  valid-child: (name) ->
    return false if @valid-children is void or @valid-children is []
    name in @valid-children

  parent-name: ->
    if @parent then @parent.full-name else ''

  # subclass should override!
  valid-parents: []
  parent: void
  child-hash: {}

  child-names: ->
    _.keys(@child-hash)

  clear: ->
    @child-hash = {}
    @update-child-count!
    @
)

module.exports = PipeFamily
