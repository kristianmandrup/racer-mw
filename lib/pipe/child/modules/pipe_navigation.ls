Module        = require('jsclass/src/core').Module
get           = require '../../../../requires' .get!

PipeNavigator = get.child-helper 'navigator'

PipeNavigation = new Module(
  navigator: ->
    @_navigator ||= new PipeNavigator @

  prev: (steps) ->
    @navigator.prev steps

  root: ->
    @navigator.root!

)

module.exports = PipeNavigation