Class       = require('jsclass/src/core').Class

requires    = require '../../../requires'

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'

ModelPipe    = requires.pipe 'model'

PipeBuilder       = requires.pipe 'builder'

ModelBuilder = new Class(PipeBuilder,
  build: ->
    args = _.values(arguments)
    switch args.length
    case 0
      throw new Error "Must take a name, a value (object) or a {name: value} as an argument"
    case 1
     @_add-model args.first!
    default
      throw new Error "Too many arguments, takes only a name, a value (object) or a {name: value}"

  _add-model: (arg) ->
    switch typeof! arg
    case 'String'
      @_name-model arg
    case 'Object'
      @_hash-model arg
    default
      throw new Error "Invalid Attribute pipe argument. Must a name (string) or an object (hash), was: #{arg}"

  _name-model: (name) ->
    @attribute name

  _hash-model: (hash) ->
    key = _.keys(hash).first!
    value = _.values(hash).first!
    switch key
    case 'collection'
      throw new Error "No such thing as a Collection model. Try adding a collection directly instead, f.ex: .collection('users')"
    case 'model'
      # just ignore the model key and go with the value ;)
      @model value
    default
      #.model(administers: project)
      # should turn into:
      #.attribute('administers').model(project)

      # reuse existing attribute functionaility :)
      @attribute hash
)

module.exports = ModelBuilder