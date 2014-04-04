Module          = require('jsclass/src/core').Module
get             = require '../../../../requires' .get!

PipeNavigation    = get.child-module 'navigation'
PipeNotification  = get.child-module 'notification'

PipeChild = new Module(
  include:
    * PipeNavigation
    * PipeNotification
    ...

  parent-name: ->
    @parent.full-name if @parent

  has-parent: ->
    @parent isnt void
  no-parent: ->
    not @has-parent!

  has-ancestors: ->
    not @no-ancestors!
  no-ancestors: ->
    lo.is-empty @ancestors!

  ancestors: ->
    my-ancestors = []
    if @parent
      my-ancestors.push @parent
      my-ancestors.push @parent.ancestors! if @parent.ancestors
    my-ancestors.flatten!.compact!
)

module.exports = PipeChild