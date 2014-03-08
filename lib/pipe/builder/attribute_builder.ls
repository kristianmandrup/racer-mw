Class       = require('jsclass/src/core').Class

requires    = require '../../../requires'

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'

AttributePipe     = requires.apipe 'attribute'
ModelPipe         = requires.apipe 'model'
CollectionPipe    = requires.apipe 'collection'
BasePipeBuilder   = requires.apipe-builder 'base'

AttributePipeBuilder = new Class(BasePipeBuilder,
  initialize: (@container) ->
    console.log 'AttributePipeBuilder', @container.describe!
    @call-super!
    @

  type: 'Builder'
  builder-type: 'Attribute'

  attach: (pipe) ->
    @container.attach pipe

  # attach an attribute pipe as a child
  build: ->
    console.log 'build', new AttributePipe('x').name
    args = _.values(arguments)
    console.log 'args', args
    switch arguments.length
    case 0
      throw new Error "Must take a name or a {name: value} as an argument"
    case 1
      @add-attribute args.first!
    default
      throw new Error "Too many arguments, takes only a name (string) or an object (hash)"

  add-attribute: (arg) ->
    console.log 'arg', arg, typeof! arg
    switch typeof! arg
    case 'String'
      @name-attribute arg
    case 'Object'
      @hash-attribute arg
    default
      throw new Error "Invalid Attribute pipe argument. Must be a name (string) or an object (hash), was: #{arg}"

  name-attribute: (name) ->
    console.log 'name-attribute', name, AttributePipe
    pipe = new AttributePipe name
    console.log 'pipe', name, pipe.describe!

    @attach pipe
    pipe

  hash-attribute: (hash) ->
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
      console.log 'default', key, value
      pipe = @pipe-from(key, value)
      @attach pipe
      pipe

  pipe-from: (key, value) ->
    if _.is-type 'Object', value
      return new ModelPipe "#{key}": value

    if _.is-type 'Array', value
      return new CollectionPipe "#{key}": value

    unless _.is-type 'String', key then
      throw new Error "Can't create pipe from: #{key}, #{value}"

    new AttributePipe "#{key}": value

)

module.exports = AttributePipeBuilder