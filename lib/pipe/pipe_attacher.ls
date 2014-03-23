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
    if typeof! pipe is 'Array'
      return @attach-list pipe

    @is-pipe pipe
    # check if ancestor is done via: @parent-validator(parent).validate @

    pipe.attach-to @
    @

  attach-list: (pipes) ->
    unless typeof! pipes is 'Array'
      throw new Error "Can only attach to a list of Pipes, was: #{typeof! pipes}"

    self = @
    pipes.each (pipe) ->
      self.attach pipe
    @

  detach: ->
    @parent = void
    @attached-to!
    @

  attach-to: (parent) ->
    @parent-validator(parent).validate @

    unless @id!
      throw new Error "id function of #{@pipe-type} Pipe returns invalid id: #{@id!}"

    @pre-attach-to parent

    parent.add-child @id!, @
    @attached-to parent

    @post-attach-to parent
    @

  pre-attach-to: (parent) ->
    @validate-attach parent

  attached-to: (parent) ->
    # update full-name
    @update-name!
    # and each of its children also need to be updated!
    for k, v of @child-hash
      @child-hash[k].update-name!
    if parent
      parent.added = @
    @

  parent-validator: (parent) ->
    new ParentValidator(parent).set-valid @valid-parents

  # throw new Error if invalid pipe for parent
  validate-attach: (parent) ->

  post-attach-to: (parent) ->
)

module.exports = PipeAttacher