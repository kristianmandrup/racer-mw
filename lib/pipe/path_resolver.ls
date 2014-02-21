Class       = require('jsclass/src/core').Class

PathResolver = new Class(
  initialize: (@model-obj) ->
    @collection = @pluralize @model-obj.$resource.$class
    @parent     = @model-obj.$pipe.$parent

  obj-path: ->
    @collection

  parent-path: ->
    if @parent? then @parent.$pipe.$calc-path else void

  full-path: ->
    [@parent-path, @obj-path].compact!.join '.'
)

module.exports = PathResolver