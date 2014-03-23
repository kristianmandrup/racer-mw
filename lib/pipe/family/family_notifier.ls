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

  initialize: (@pipe, @options = {}) ->
    @is-pipe @pipe
    @parent = @pipe.parent
    @not-parent = @options.parent
    @

  not-child: ->
    @nc ||= @options.child or not @pipe.has-children or @pipe.child-count is 0

  child-list: ->
    @pipe.child-list!

  notify-family: (@updated-value, options = {}) ->
    @notify-children @pipe unless @not-child!
    @notify-ancestors! unless @not-parent

  notify-children: (pipe)->
    @is-pipe pipe
    for child in @child-list!
      child.on-parent-update pipe, @updated-value

  notify-ancestors: ->
    return unless @parent
    @parent.on-child-update(@pipe, @updated-value)
)

module.exports = FamilyNotifier