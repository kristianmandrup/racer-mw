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

  allow-children: true

  has-children: ->
    @child-count > 0
  no-children: ->
    not @has-children!

  has-parent: ->
    @parent isnt void
  no-parent: ->
    not @has-parent!

  has-ancestors: ->
    not @no-ancestors!
  no-ancestors: ->
    lo.is-empty @ancestors!

  ancestors: ->
    my-ancestors = []
    if @parent
      my-ancestors.push @parent
      my-ancestors.push @parent.ancestors! if @parent.ancestors
    my-ancestors.flatten!.compact!

  child: (name) ->
    unless @child-hash[name] then
      throw new Error "Pipe has no named: #{name}"
    @child-hash[name]

  remove-child: (name) ->
    removed = lo.extend {}, @child-hash[name]
    removed.parent = void
    delete @child-hash[name]
    @update-child-count!
    removed

  add-child: (name, pipe) ->
    @validate-child name pipe
    pipe.parent = @
    @child-hash[name] = pipe
    @update-child-count!

  validate-child: (name, pipe) ->
    unless _.is-type 'String', name
      throw new Error "Name of pipe added must be a String, was: #{name}"

    unless _.is-type 'Object', pipe
      throw new Error "Pipe added as child must be an Object, was: #{pipe}"

    unless @has-children
      throw new Error "This pipe does not allow child pipes"

  update-child-count: ->
    @child-count = @child-names!.length

  child-count: 0

  child-list: ->
    _.values(@child-hash).compact!

  # TODO: Avoid switch use or
  get: (index) ->
    switch typeof! index
    case 'Number'
      @get-by-index index
    case 'String'
      @child index
    default
      throw new Error "Must be a Number index or name of a child, was: #{index} #{typeof! index}"

  get-by-index: (index) ->
    if index < 0
      throw new Error "Index must be 0 or higher, was: #{index}"
    num = @child-names!.length
    if index >= num
      throw new Error "Index #{index} too high, Pipe has #{num} children"
    @child-list![index]

  first: ->
    @get 0

  last: ->
    @get @child-names!.length-1

  attr: (name) ->
    p = @child name
    @validate-attribute p, name

  validate-attribute: (p, name) ->
    unless p.pipe-type is 'Attribute'
      throw new Error "The child pipe #{name} is not an Attribute"

  modl: (name) ->
    p = @child name
    @validate-model name

  validate-model: (p, name) ->
    unless p.pipe-type is 'Model'
      throw new Error "The child pipe #{name} is not a Model"

  col: (name) ->
    p = @child name
    @validate-collection p, name

  validate-collection: (p, name) ->
    unless p.pipe-type is 'Collection'
      throw new Error "The child pipe #{name} is not a Collection"

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
