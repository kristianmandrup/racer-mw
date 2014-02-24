Class       = require('jsclass/src/core').Class

requires = require '../../requires'

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

BasePipe          = requires.pipe 'base'

# Must be on a model
AttributePipe = new Class(BasePipe,
  initialize: (@parent, @name) ->
    @validate!
    @call-super @name

  # TODO: refactor! extract into module or class
  model: ->
    switch arguments.length
    case 0
      throw new Error "Must take a name, a value (object) or a {name: value} as an argument"
    case 1
     @_add-model arguments[0]
    default
      throw new Error "Too many arguments, takes only a name, a value (object) or a {name: value}"

  _add-model: (arg) ->
    switch typeof arg
    case 'string'
      name = arg
      # TODO: constructor when passed a name should create empty object like this
      @attach new ModelPipe {_clazz: name}
    case 'object'
      value = arg
      @attach new ModelPipe value
    default
      throw new Error "Invalid Attribute pipe argument. Must a name (string) or an object (hash), was: #{arg}"

  # TODO: refactor! extract into module or class
  collection: ->
    switch arguments.length
    case 0
      throw new Error "Must take a name, a value (object) or a {name: value} as an argument"
    case 1
     @_add-collection arguments[0]
    default
      throw new Error "Too many arguments, takes only a name, a value (object) or a {name: value}"

  _add-collection: (arg) ->
    switch typeof arg
    case 'string'
      name = arg
      # TODO: constructor should auto-pluralize name!?
      @attach new CollectionPipe arg.pluralize!
    case 'object'
      value = arg
      # TODO: constructor if given a name: [list] should set up correctly
      @attach new CollectionPipe arg
    default
      throw new Error "Invalid pipe argument. Must a name (string) or an object (hash), was: #{arg}"


)

module.exports = AttributePipe