Class       = require('jsclass/src/core').Class
_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'

BaseExtractor = new Class(
  initialize: (@obj) ->
    @validate!
    @

  validate: ->
    if @obj is void
      throw new Error "Must take a String or Object, was: #{util.inspect @obj}"

  inner-obj: ->
    @obj = @first-value! if @valid-obj @first-value!

  valid-obj: (obj) ->
    @is-object(obj) and typeof! obj is 'Object'

  first-value: ->
    @fv ||= @values!.first!

  values: ->
    _.values @obj

  first-key: ->
    @keys!.first!

  keys: ->
    _.keys(@obj)

  normalized: (val) ->
    val unless lo.is-empty val

  is-string: ->
    typeof! @obj is 'String'

  valid-string: ->
    @is-string! and not @obj.is-blank!

  valid-clazz: ->
    @has-clazz! and not @obj._clazz.is-blank!

  has-clazz: ->
    typeof! @obj._clazz is 'String'

  is-object: ->
    typeof! @obj is 'Object'
)

module.exports = BaseExtractor