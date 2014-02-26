Class       = require('jsclass/src/core').Class

# TODO: Needs to be updated for new Design!
PathResolver = new Class(
  initialize: (@model-obj) ->
    @collection = @pluralize @model-obj.$resource.$class
    @parent     = @model-obj.$pipe.$parent

  # this is "old school"
  obj-path: ->
    @collection

  parent-path: ->
    if @parent? then @parent.$pipe.$calc-path else void

  full-path: ->
    [@parent-path, @obj-path].compact!.join '.'
)

module.exports = PathResolver