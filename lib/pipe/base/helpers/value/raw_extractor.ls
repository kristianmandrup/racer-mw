Class       = require('jsclass/src/core').Class

RawExtractor = new Class(
  initialize: (@pipe, @obj, @contained) ->
    @pipe-type = @pipe.pipe-type

  id: ->
    @pipe.id!

  inner-raw: ->
    return {(@id!): @obj} if @contained
    @obj

  child-value: (child) ->
    return child.raw-value! if @is-collection!
    child.raw-value true

  is-collection: ->
    @pipe-type is 'Collection'
)

module.exports = RawExtractor