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
    @reset!
    @

  type: 'Notifier'

  config-options: ->
    @not-child  = @options.no-child or @pipe.no-children!
    @not-parent = @options.no-parent or @parent is void
    @

  child-list: ->
    @pipe.child-list!

  reset: ->
    @parent-notified = false
    @children-notified = false

  # TODO: allow config-options here?
  notify-family: (@updated-value, options = {}) ->
    @reset!
    @notify-children!
    @notify-parent!

  notify-children: ->
    return if @not-child
    for child in @child-list!
      child.on-parent-update @pipe, @updated-value
    @children-notified = true

  notify-parent: ->
    return if @not-parent
    @parent.on-child-update(@pipe, @updated-value)
    @parent-notified = true
)

module.exports = FamilyNotifier