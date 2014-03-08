Class       = require('jsclass/src/core').Class

requires    = require '../../../requires'

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'

ModelPipe    = requires.apipe 'model'

BasePipeBuilder  = requires.apipe-builder 'base'

ModelPipeBuilder = new Class(BasePipeBuilder,
  initialize: ->
    @call-super!
    @

  type: 'Builder'
  builder-type: 'Model'

  build: ->
    args = _.values(arguments)
    switch args.length
    case 0
      throw new Error "Must take a name, a value (object) or a {name: value} as an argument"
    case 1
     @add-model args.first!
    default
      throw new Error "Too many arguments, takes only a name, a value (object) or a {name: value}"

  add-model: (arg) ->
    console.log typeof! arg
    switch typeof! arg
    case 'String'
      name = arg
      new ModelPipe name
    case 'Object'
      hash = arg
      @hash-model hash
    default
      throw new Error "Invalid Model pipe argument. Must a name (string) or an object (hash), was: #{arg}"

  name-model: (name) ->
    new ModelPipe name

  hash-model: (hash) ->
    key = _.keys(hash).first!
    value = _.values(hash).first!
    switch key
    case 'collection'
      throw new Error "No such thing as a Collection model. Try adding a collection directly instead, f.ex: .collection('users')"
    case 'model'
      # just ignore the model key and go with the value ;)
      @build value
    default
      new ModelPipe hash
)

module.exports = ModelPipeBuilder