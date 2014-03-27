Class = require('jsclass/src/core').Class
require 'sugar'

TupleKeyTyper = new Class(
  initialize: (@key) ->

  tuple-type-is: ->
    @ttype-is ||= @_tuple-type-is(@tuple-type!)

  _tuple-type-is: (@type) ->
    self = @
    # creates functions
    [\plural \single \path \none].each (name) ->
      self[name] = ->
        @type is name.capitalize!

  tuple-type: ->
    # @validate-string-key!
    # @is-path! or @is-single! or @is-plural! or @is-none!
    @any-of \path \single \plural \none

  any-of: (...names) ->
    self = @
    names.flatten!.any (name) (-> self[name] )

  path: ->
    'Path'    if @a-path!

  single: ->
    'Single'  if @a-single!

  plural: ->
    'Plural'  if @a-plural!

  none: ->
    throw new Error "Can't determine tupel type from key: #{@key}"

  a-plural: ->
    @key.pluralize!   is @key

  a-single: ->
    @key.singularize! is @key

  a-path: ->
    @key[0] in ['_', '$']
)

module.exports = TupleKeyTyper