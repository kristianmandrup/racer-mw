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
    @build \collection if @list-is.collection!

  attributes: ->
    @build \attributes if @list-is.attributes!

  model: ->
    @build \model      if @value-is.model!

  attribute: ->
    @build \attribute  if @value-is.attribute!

  # if path pipe?
  path: ->
    @build \children, @path-pipe! if @tuple-type-is \path

  unknown: ->
    @build \model if @value-is.unknown!

  no-list: ->
    throw new Error "Unable to determine if plural: #{@key} is a collection or array"

  no-item: ->
    throw new Error "Single value for #{@key} should be Object, Number or String, was: #{typeof! @value}, #{@value}"

  path-pipe: ->
    new PathPipe @key
)

module.exports = TupleBuilder
