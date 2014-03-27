Module       = require('jsclass/src/core').Module

TupleBuilder = new Class(
  initialize: (@tuple-parser) ->
    [\list-is \value-is \tuple-type-is \key \value].each (name) ->
      @[name] = @tuple-parser[name]
    @

  build: (name, key, value) ->
    value ||= @value; key ||= @key
    @parser-builder(name).build key, value

  parser-builder: (name) ->
    new ParserBuilder name

  any-of: -> (names) ->
    self = @
    names.flatten!.any (name) (-> @[name])

  collection: ->
    @list-build \collection

  attributes: ->
    @list-build \attributes

  list-build: (name) ->
    @build name if @list-is[name]

  model: ->
    @value-build \model

  attribute: ->
    @value-build \attribute

  unknown: ->
    @value-build \model \unknown

  value-build: (name, type = nil) ->
    @build name if @value-is[type or name]

  # if path pipe?
  path: ->
    @build \children, @path-pipe! if @tuple-type-is \path

  no-list: ->
    throw new Error "Unable to determine if plural: #{@key} is a collection or array"

  no-item: ->
    throw new Error "Single value for #{@key} should be Object, Number or String, was: #{typeof! @value}, #{@value}"

  path-pipe: ->
    new PathPipe @key
)

module.exports = TupleBuilder
