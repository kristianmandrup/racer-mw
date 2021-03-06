Class   = require('jsclass/src/core').Class
get     = require '../../../requires' .get!
lo  = require 'lodash'
require 'sugar'

ModelPipe        = get.apipe 'model'
BasePipeBuilder  = get.base-builder 'base'

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
      pipe = @add-model args.first!
    default
      throw new Error "Too many arguments, takes only a name, a value (object) or a {name: value}"
    @attach pipe
    pipe

  post-attach: (pipe) ->
    if pipe.clazz is void
      parent = pipe.parent
      if parent and parent.pipe-type is 'Collection'
        pipe.clazz = parent.name.singularize!

  add-model: (arg) ->
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