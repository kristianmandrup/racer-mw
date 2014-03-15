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
    @call-super!
    @

  type: 'Builder'
  builder-type: 'Attribute'

  # attach an attribute pipe as a child
  build: ->
    args = _.values(arguments)
    switch arguments.length
    case 0
      throw new Error "Must take a name or a {name: value} as an argument"
    case 1
      pipe = @add-attribute args.first!
    default
      throw new Error "Too many arguments, takes only a name (string) or an object (hash)"
    @attach pipe
    pipe

  add-attribute: (arg) ->
    switch typeof! arg
    case 'String'
      @name-attribute arg
    case 'Object'
      @hash-attribute arg
    default
      throw new Error "Invalid Attribute pipe argument. Must be a name (string) or an object (hash), was: #{arg}"

  name-attribute: (name) ->
    new AttributePipe name

  hash-attribute: (hash) ->
    key = _.keys(hash).first!
    value = _.values(hash).first!
    create-pipe key, value

  create-pipe: (key, value) ->
    switch key
    case 'collection'
      # since attribute should only be for simple types, String, Int etc.
      new CollectionPipe(value)
    case 'model'
      # since attribute should only be for simple types, String, Int etc.
      new ModelPipe(_clazz: value)
    default
      # what should really happen here?
      # .model(administers: project)
      # should turn into:
      # .attribute('administers').model(project)
      @pipe-from(key, value)

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