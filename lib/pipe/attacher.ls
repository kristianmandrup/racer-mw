Module       = require('jsclass/src/core').Module

_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

requires = require '../../requires'

ParentValidator   = requires.pipe 'validator/parent_validator'

# TODO: make into a class?
Attacher = new Module(
  # when attached, a pipe should update its cached full-name
  attach: (pipe) ->
    unless _.is-type('Object', pipe)
      throw new Error "Can only attach to a Pipe which is an Object was: #{typeof! pipe}"

    unless pipe.type is 'Pipe'
      throw new Error "Can only attach to a Pipe object, was: #{util.inspect pipe}, type: #{pipe.type}"
    pipe.attach-to @

  detach: ->
    @parent = void
    @_attached-to!
    @

  attach-to: (parent) ->
    @parent-validator(parent).validate @

    unless @id!
      throw new Error "id function of #{@pipe-type} Pipe returns invalid id: #{@id!}"

    @pre-attach-to parent

    parent.children[@id!] = @
    @parent = parent
    @attached-to parent

    @post-attach-to parent
    @

  pre-attach-to: (parent) ->
    @validate-attach parent

  attached-to: (parent) ->
    @parent = parent
    # update full-name
    @update-name!
    # and each of its children also need to be updated!
    for k, v of @children
      @children[k].update-name!
    if parent
      parent.added = @
    @


  parent-validator: (parent) ->
    new ParentValidator(parent).set-valid @valid-parents

  # throw new Error if invalid pipe for parent
  validate-attach: (parent) ->

  post-attach-to: (parent) ->
)

module.exports = Attacher