Module       = require('jsclass/src/core').Module

_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

requires = require '../../requires'

ParentValidator   = requires.pipe 'validator/parent_validator'

PipeAttacher = new Module(
  # when attached, a pipe should update its cached full-name
  attach: (pipe) ->
    return @attach-list pipe if typeof! pipe is 'Array'
    @is-pipe pipe
    pipe.attach-to @
    @

  attach-list: (pipes) ->
    unless typeof! pipes is 'Array'
      throw new Error "Can only attach to a list of Pipes, was: #{typeof! pipes}"

    self = @
    lo.each pipes @attach
    @

  detach: ->
    @parent = void
    @attached-to!
    @

  attach-to: (parent) ->
    @parent-validator(parent).validate @
    @validate-id!

    @pre-attach-to parent

    parent.add-child @id!, @
    @attached-to parent

    @post-attach-to parent
    @

  validate-id: ->
    unless @id!
      throw new Error "id function of #{@pipe-type} Pipe returns invalid id: #{@id!}"

  pre-attach-to: (parent) ->
    @validate-attach parent

  attached-to: (parent) ->
    # update full-name
    @update-name!
    @update-child-names!
    parent.added = @ if parent
    @

  update-child-names: ->
    for k, v of @child-hash
      @child-hash[k].update-name!

  parent-validator: (parent) ->
    new ParentValidator(parent).set-valid @valid-parents

  # throw new Error if invalid pipe for parent
  validate-attach: (parent) ->

  post-attach-to: (parent) ->
)

module.exports = PipeAttacher