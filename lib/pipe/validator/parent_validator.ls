Class       = require('jsclass/src/core').Class

require 'sugar'
util  = require 'util'
_     = require 'prelude-ls'

requires = require '../../../requires'

Pipe = requires.apipe 'base'

klass-of = (obj) ->
  if typeof obj is 'object' and obj.klass
    obj.klass.display-name || typeof! obj
  else
    typeof(obj)

is-pipe = (obj) ->
  return false unless typeof obj is 'object'
  obj.type and obj.type is 'Pipe'

ParentValidator = new Class(
  initialize: (@parent) ->
    unless @parent
      throw new Error "Missing parent pipe argument in #{util.inspect _.values(arguments)}"

    unless typeof @parent is 'object'
      throw new Error "Argument error: Parent must be an object, was a #{klass-of @parent}"

    unless is-pipe @parent
      throw new Error "Argument error: Parent must be a kind of Pipe, was a #{klass-of @parent} type: #{@parent.type}"
    @

  set-valid: (valid-parent-types) ->
    @valid-parent-types = [valid-parent-types].flatten!.compact!
    @

  validate-args: ->
    unless @pipe
      throw new Error "Missing child pipe argument in #{util.inspect arguments}"

    unless is-pipe @pipe
      throw new Error "Argument error: Child must be a kind of Pipe, was a #{klass-of @pipe}"

    if @pipe is @parent
      throw new Error "Circular error: you can't attach to yourself, #{util.inspect @pipe}"

    if @is-ancestor @pipe
      throw new Error "Circular error: you can't attach an ancestor pipe, #{util.inspect @parent}"

  is-ancestor: (pipe) ->
    pipe in @ancestors!

  ancestors: ->
    @parent.ancestors!

  validate: (@pipe) ->
    @validate-args!

    unless @valid-type!
      throw new Error "Invalid parent pipe for #{util.inspect @pipe} [#{@parent.pipe-type}], must be one of: #{@valid-parent-types}"

  valid-type: ->
    return false if @valid-parent-types is void
    return false if @valid-parent-types.length is 0
    return false unless @parent.type
    @parent.pipe-type.to-lower-case! in @valid-parent-types
)


module.exports = ParentValidator