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
    @tuple-key-type-detector.tuple-type-is!

  tuple-key-type-detector: ->
    @detector ||= new TupleKeyTypeDetector @tuple-type!

  tuple-type: ->
    # @validate-string-key!
    # @is-path! or @is-single! or @is-plural! or @is-none!
    @any-of \path \single \plural \none

  any-of: (...names) ->
    _.find @[name], names.flatten!

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