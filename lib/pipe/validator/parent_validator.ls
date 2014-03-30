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
    @is-pipe @parent
    @

  set-valid: (valid-parent-types) ->
    @valid-parent-types = [valid-parent-types].flatten!.compact!
    @

  validate-pipe-relations: ->
    @validate-parent!
    @validate-ancestor!

  validate-parent: ->
    if @pipe is @parent
      throw new Error "Circular error: you can't attach to yourself, #{@pipe.describe!}"

  validate-ancestor: ->
    if @is-ancestor @pipe
      throw new Error "Circular error: you can't attach an ancestor pipe, #{@parent.describe!}"

  is-ancestor: (pipe) ->
    pipe in @ancestors!

  ancestors: ->
    @parent.ancestors!

  validate: (@pipe) ->
    @is-pipe @pipe
    @validate-pipe-relations!
    @validate-type!

)


module.exports = ParentValidator