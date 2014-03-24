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
    @is-pipe @pipe # or call-super ?
    @parent = @pipe.parent
    @config-options!
    @

  config-options: ->
    @not-child  = @options.no-child or not @pipe.has-children or @pipe.child-count is 0
    @not-parent = @options.no-parent

  child-list: ->
    @pipe.child-list!

  # TODO: allow config-options here?
  notify-family: (@updated-value, options = {}) ->
    @notify-children! unless @not-child
    @notify-parent! unless @not-parent

  notify-children: ->
    for child in @child-list!
      child.on-parent-update @pipe, @updated-value

  notify-parent: ->
    return unless @parent
    @parent.on-child-update(@pipe, @updated-value)
)

module.exports = FamilyNotifier