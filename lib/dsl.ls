requires = require '../requires'
require 'sugar'
Class       = require('jsclass/src/core').Class

# should contain the main GLOBAL DSL methods that are exported

CollectionNamer = new Class(
  initialize: (@obj, @collection) ->

  # TODO: refactor switch!
  get: ->
    switch typeof @collection
    case 'string'
      @collection
    default
      @get-from-obj!

  get-from-obj: ->
    @validate-obj!
    name = obj._clazz.pluralize!

  validate-obj: ->
    unless typeof @obj is 'object'
      throw new Error "Invalid value object argument. Must be an object, was: #{@obj}"
    unless @obj._clazz
      throw new Error "value object missing a _clazz key, was: #{@obj}"

)

CollectionPipe = requires.pipe('collection')
PathPipe       = requires.pipe 'path'

module.exports =
  # Pipe methods that can be used to start a new pipe!

  collection: (name) ->
    unless typeof name is 'string'
      throw new Error "Name of collection pipe must be a String, was: #{name}"
    new CollectionPipe name

  # model should never be a "root node"
  # just a shorthand for the common task of creating a collection with a model
  model: (obj, collection = void) ->
    unless typeof obj is 'object'
      throw new Error "Invalid Model pipe argument. Must be an object, was: #{obj}"
    col-pipe = @collection(new CollectionNamer(obj, collection).get!)
    col-pipe.model obj

  path: (name) ->
    new PathPipe name

  # alias
  container: (name) ->
    @path name