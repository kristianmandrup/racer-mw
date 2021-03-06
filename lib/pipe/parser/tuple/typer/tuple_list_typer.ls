Class = require('jsclass/src/core').Class

require 'sugar'

TupleListTyper = new Class(
  initialize: (@value) ->

  list-type: ->
    @_list-type ||= @calc-list-type!

  calc-list-type: ->
    @validate-array "plural value"
    @any-of(\empty \collection \attributes) or 'mixed'

  any-of: -> (names) ->
    self = @
    names.flatten!.find (name) (-> self[name])

  empty: ->
    'empty'       if @is-empty!

  is-empty: ->
    not @value or @value.length is 0

  collection: ->
    'collection'  if @all-objects!

  all-objects: ->
    @all-are 'Object'

  attribute: ->
    'attribute'   if @all-primitives

  all-primitives: ->
    @all-are @primitive-types

  all-are: (...types) ->
    lo.every @value, @is-type(types)

  is-type (...types) ->
    types = [types].flatten!
    (item )->
      typeof! item in types

  primitive-types: [\String \Number]

  list-is: (@type) ->
    any-of: -> (names) ->
      self = @
      names.flatten!.find (name) (-> self[name])

    attributes: ->
      @type is 'attributes'

    collection: ->
      @type in @collection-types

    collection-types: <[collection empty]>
)

module.exports = TupleListTyper