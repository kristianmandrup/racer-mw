Class        = require('jsclass/src/core').Class

_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'


FamilyNotifier = new Class(
  initialize: (@pipe) ->
    @parent = @pipe.parent
    @child-list = @pipe.child-list!
    @

  notify-family: (@updated-value) ->
    @notify-children @pipe
    @notify-ancestors!

  notify-children: (pipe)->
    parent = @parent
    @child-list.each (child) ->
      child.on-parent-update parent, @updated-value

  notify-ancestors: ->
    @parent.on-child-update(@, @updated-value) if @parent
)

module.exports = FamilyNotifier