crud =
  Get:    require 'crud/crud_get'
  Set:    require 'crud/crud_set'
  Delete: require 'crud/crud_delete'

module.exports = new Class(
  initialize (@collection) ->
    @model = app.model
 
  extend:
    create: (args) ->
      # new @
 
  ctx: (ctx) ->
    lo.extend {collection: @collection}, ctx
 
  factory: ->
    name = arguments.first
    switch typeof arguments
    case 'object'
      new crud[name] @ctx(arguments)
    default
      crud[name].create @collection, arguments
 
  get: ->
    factory 'Get', arguments
 
  set: ->
    factory 'Set', arguments
 
  delete: ->
    factory 'Delete', arguments
)
