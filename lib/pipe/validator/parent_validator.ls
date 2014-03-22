Class       = require('jsclass/src/core').Class

require 'sugar'
util  = require 'util'
_     = require 'prelude-ls'

requires = require '../../../requires'

Pipe = requires.apipe 'base'

PipeValidation = requires.pipe 'pipe_validation'

klass-of = (obj) ->
  if typeof obj is 'object' and obj.klass
    obj.klass.display-name || typeof! obj
  else
    typeof(obj)

ParentValidator = new Class(
  include:
    * PipeValidation
    ...

  initialize: (@parent) ->
    unless @parent
      throw new Error "Missing parent pipe argument in #{util.inspect _.values(arguments)}"
    @is-pipe @parent
    @

  set-valid: (valid-parent-types) ->
    @valid-parent-types = [valid-parent-types].flatten!.compact!
    @

  validate-args: ->
    @is-pipe @pipe

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

    @is-pipe @pipe

    unless @valid-type!
      console.log @pipe.describe!
      throw new Error "#{@parent.pipe-type} is an invalid parent pipe for #{@pipe.pipe-type}, must be one of: #{@valid-parent-types}"

  valid-type: ->
    return true if @valid-parent-types is void
    return true if @valid-parent-types.length is 0
    @parent.pipe-type.to-lower-case! in @valid-parent-types
)


module.exports = ParentValidator