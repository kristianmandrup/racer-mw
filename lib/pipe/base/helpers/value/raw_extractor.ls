Class       = require('jsclass/src/core').Class

RawExtractor = new Class(
  initialize: (@pipe, @obj, @contained) ->
    @pipe-type = @pipe.pipe-type

  id: ->
    @pipe.id!

  inner-raw: ->
    @contained-value! or @obj

  contained-value: ->
    {(@id!): @obj} if @contained

  child-value: (child) ->
    @collection-value(child) or child.raw-value(true)

  collection-value: (child) ->
    child.raw-value! if @is-collection!

  # TODO: should check parent type, no?
  is-collection: ->
    @pipe-type is 'Collection'
)

module.exports = RawExtractor