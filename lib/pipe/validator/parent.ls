Class       = require('jsclass/src/core').Class

require 'sugar'
util = require 'util'

requires = require '../../../requires'

Pipe = requires.apipe 'base'

klass-of = (obj) ->
  if typeof obj is 'object' and obj.klass
    obj.klass.display-name
  else
    typeof(obj)

is-pipe = (obj) ->
  return false unless typeof obj is 'object'
  if obj.type
    obj.type is 'Pipe'

ParentValidator = new Class(
  initialize: (valid-parent-types) ->
    @valid-parent-types = [valid-parent-types].flatten!.compact!
    @

  validate-args: ->
    unless @parent
      throw new Error "Missing parent pipe argument in #{util.inspect arguments}"

    unless @pipe
      throw new Error "Missing child pipe argument in #{util.inspect arguments}"

    unless is-pipe @parent
      throw new Error "Argument error: Parent must be a kind of Pipe, was a #{klass-of @parent}"

    unless is-pipe @pipe
      throw new Error "Argument error: Child must be a kind of Pipe, was a #{klass-of @pipe}"

    if @parent is @pipe
      throw new Error "Argument error: same pipe used as parent and child, #{util.inspect @parent}"

  validate: (@parent, @pipe) ->
    @validate-args!

    unless @valid-type!
      throw new Error "Invalid parent pipe for #{util.inspect @pipe} [#{@pipe.type}], must be one of: #{@valid-parent-types}"

  valid-type: ->
    return true if @valid-parent-types.length is 0
    return false unless @parent.type
    @parent.type in @valid-parent-types
)


module.exports = ParentValidator