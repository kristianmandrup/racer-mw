requires = require '../../../../requires'

Class       = require('jsclass/src/core').Class

util  = require 'util'
require 'sugar'

Debugging = requires.lib 'debugging'

TupleBaseParser = new Class(

  # include Modules (mixins)
  include:
    * Debugging
    ... # ensures it is a list even if only one item!

  initialize: (@key, @value) ->
    @validate-string-key!
    @

  # test if value is list of Object or list of simple types
  # if mixed, throw error
  list-type: ->
    @_list-type ||= @calc-list-type!

  build: (name, key, value) ->
    value ||= @value; key ||= @key
    @build name, key, value

  # protected

  calc-list-type: ->
    @validate-array "plural value #{@key}"
    @is-empty! or @is-collection! or @is-array! or 'mixed'

  is-empty: ->
    'empty' if @value.length is 0

  is-collection: ->
    'collection' if @all-are 'Object'

  is-array: ->
    'array' if @all-are @primitive-types!

  all-are: (types) ->
    @value.every (item) ->
      typeof! item in [types].flatten!

  primitive-types:
    * \String
    * \Number

  validate-array: (msg = 'value')->
    unless typeof! @value is 'Array'
      throw new Error "#{msg} must be an Array, was: #{typeof! @value} #{util.inspect @value}"

  validate-string-key: ->
    unless typeof! @key is 'String'
      throw new Error "Key must be a String, was: #{typeof! @key}, #{util.inspect @key}"
)

module.exports = TupleBaseParser