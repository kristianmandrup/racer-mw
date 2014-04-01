Class       = require('jsclass/src/core').Class

require 'sugar'

# Must be on a model or path pipe
ParentAttacher = new Class(
  initialize: (@pipe) ->

  attach-to: (@parent) ->
    @validate-parent!
    @set-id!
    @set-class!
    @pipe

  set-id: ->
    @pipe.object-id = @parent.next-child-id!

  set-class: ->
    @pipe.clazz = @parent.name.singularize! if @pipe.clazz is void

  validate-parent: ->
    unless @is-collection!
      throw new Error "Parent must be a CollectionPipe, was: #{@parent.pipe-type}"

  is-collection: ->
    @parent.pipe-type is 'Collection'
)

module.exports = ParentAttacher