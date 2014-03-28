Class = require('jsclass/src/core').Class
require 'sugar'

TupleKeyTyper = new Class(
  initialize: (@key) ->
    unless typeof! @key is 'String'
      throw new TypeError "Key must be a String, was: #{typeof! @key} -  #{@key}"
    @build-type-detectors!
    @build-type-finders!
    @

  tuple-type-is: ->
    @ttype-is ||= @_tuple-type-is(@tuple-type!)

  _tuple-type-is: (type) ->
    self = @
    type-detectors.find () ->
      @["is#{detector.capitalize!}"]! is type

  build-type-detectors: ->
    # creates functions
    self = @
    @type-detectors!.each (name) ->
      self[name] = (name) ->
        @type is name.capitalize!

  type-detectors: <[plural single path none]>

  tuple-type: ->
    # @validate-string-key!
    # @is-path! or @is-single! or @is-plural! or @is-none!
    @any-of \path \single \plural \none

  any-of: (...names) ->
    self = @
    names.flatten!.any (name) ->
      self[name]

  # path: ->
  #  'Path'    if @a-path!
  build-type-finders: ->
    self = @
    type-finders.each (finder) ->
      fun = finder.capitalize!
      self[finder] = ->
        fun if @["a#{fun}"]


  none: ->
    throw new Error "Can't determine tuple type from key: #{@key}"

  a-plural: ->
    @key.pluralize!   is @key

  a-single: ->
    @key.singularize! is @key

  a-path: ->
    @key[0] in ['_', '$']
)

module.exports = TupleKeyTyper