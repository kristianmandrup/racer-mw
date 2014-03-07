Class       = require('jsclass/src/core').Class

requires    = require '../../../requires'

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'

AttributePipe     = requires.pipe 'attribute'
ModelPipe         = requires.pipe 'model'
CollectionPipe    = requires.pipe 'collection'

PipeBuilder       = requires.pipe 'builder'

AttributeBuilder = new Class(PipeBuilder,
  initialize: (@container) ->

  attach: (pipe) ->
    @container.attach pipe

  # attach an attribute pipe as a child
  build: ->
    args = _.values(arguments)
    switch arguments.length
    case 0
      throw new Error "Must take a name or a {name: value} as an argument"
    case 1
      @_add-attribute args.first!
    default
      throw new Error "Too many arguments, takes only a name (string) or an object (hash)"

  _add-attribute: (arg) ->
    switch typeof! arg
    case 'String'
      @_name-attribute arg
    case 'Object'
      @_hash-attribute arg
    default
      throw new Error "Invalid Attribute pipe argument. Must be a name (string) or an object (hash), was: #{arg}"

  _name-attribute: (name) ->
    pipe = new AttributePipe name
    @attach pipe
    pipe

  _hash-attribute: (hash) ->
    key = _.keys(hash).first!
    value = _.values(hash).first!
    switch key
    case 'collection'
      # since attribute should only be for simple types, String, Int etc.
      collection = new CollectionPipe(value)
      @attach collection
      collection
    case 'model'
      # since attribute should only be for simple types, String, Int etc.
      model = new ModelPipe(_clazz: value)
      @attach model
      model
    default
      # what should really happen here?
      # .model(administers: project)
      # should turn into:
      # .attribute('administers').model(project)
      pipe = @_pipe-from(key, value)
      @attach pipe
      pipe

  _pipe-from: (key, value) ->
    if _.is-type 'Object', value
      return new ModelPipe "#{key}": value
    if _.is-type 'Array', value
      return new CollectionPipe "#{key}": value

    return new AttributePipe "#{key}": value
)

module.exports = AttributeBuilder