Class        = require('jsclass/src/core').Class

_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

requires = require '../../../requires'

PipeValidation      = requires.pipe 'pipe_validation'

FamilyNotifier = new Class(
  include:
    * PipeValidation
    ...

  initialize: (@pipe, options = {}) ->
    @is-pipe @pipe

    @parent = @pipe.parent
    @not-parent = options.parent
    @not-child  = options.child
    @

  child-list: ->
    @pipe.child-list!

  notify-family: (@updated-value) ->
    @notify-children @pipe unless @not-child
    @notify-ancestors! unless @not-parent

  notify-children: (pipe)->
    @is-pipe pipe

    for child in @child-list!
      child.on-parent-update @parent, @updated-value

  notify-ancestors: ->
    @parent.on-child-update(@, @updated-value) if @parent
)

module.exports = FamilyNotifier