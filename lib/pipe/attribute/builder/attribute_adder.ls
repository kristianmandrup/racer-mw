Class   = require('jsclass/src/core').Class
get     = require '../../../../requires'
lo      = require 'lodash'
require 'sugar'

ModelPipe       = get.apipe 'model'
CollectionPipe  = get.apipe 'collection'

AttributeAdder = new Class(
  initialize: (@builder) ->
    @

  is: (type) ->
    typeof! @obj is type.capitalize!

  add: (@obj) ->
    @name-attribute! or @hash-attribute! or @none!

  name-attribute: ->
    new AttributePipe @obj if @is 'string'

  hash-attribute: ->
    @create-pipe!

  key: ->
    @_key    ||= _.keys(value).first!

  value: ->
    @_value  ||= _.values(value).first!

  none: ->
    throw new Error "Invalid Attribute pipe argument. Must be a name (string) or an object (hash), was: #{@obj}"

  select-pipe: ->
    lo.find @pipe-types, @create-pipe, @

  pipe-types: <[collection model other]>

  create-pipe: (type) ->
    @[type] if @key is type

  collection: ->
    new CollectionPipe(@value)

  # TODO: what kind of Model? Collection or Attribute or parse to determine?
  model: ->
    new ModelPipe(_clazz: @value)

  # TODO: Use normal object model parser here!
  other: ->
    throw new Error "TODO: Use normal object model parser here!"
)

module.exports = AttributeAdder