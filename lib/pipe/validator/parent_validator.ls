Class       = require('jsclass/src/core').Class

require 'sugar'
util  = require 'util'
_     = require 'prelude-ls'
lo    = require 'lodash'

requires = require '../../../requires'

Pipe = requires.apipe 'base'

PipeValidation = requires.pipe 'pipe_validation'

ParentValidator = new Class(
  include:
    * PipeValidation
    ...

  initialize: (@parent) ->
    unless @parent
      throw new Error "Missing parent pipe argument"
    @is-pipe @parent
    @

  set-valid: (valid-parent-types) ->
    @valid-parent-types = [valid-parent-types].flatten!.compact!
    @

  validate-pipe-relations: ->
    if @pipe is @parent
      throw new Error "Circular error: you can't attach to yourself, #{@pipe.describe!}"

    if @is-ancestor @pipe
      throw new Error "Circular error: you can't attach an ancestor pipe, #{@parent.describe!}"

  is-ancestor: (pipe) ->
    pipe in @ancestors!

  ancestors: ->
    @parent.ancestors!

  validate: (@pipe) ->
    @is-pipe @pipe
    @validate-pipe-relations!

    unless @valid-type!
      console.log @pipe.describe!
      throw new Error "#{@parent.pipe-type} is an invalid parent pipe for #{@pipe.pipe-type}, must be one of: #{@valid-parent-types}"

  valid-type: ->
    return true if @no-valid-parent-types!
    @parent.pipe-type.to-lower-case! in @valid-parent-types

  no-valid-parent-types: ->
    lo.is-empty @valid-parent-types
)


module.exports = ParentValidator