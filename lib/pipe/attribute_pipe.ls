Class       = require('jsclass/src/core').Class

requires = require '../../requires'

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'

BasePipe          = requires.apipe 'base'
ModelPipe         = requires.apipe 'model'

unpack = (arg) ->
  switch typeof! arg
  case 'String'
    [arg, void]
  # allow object, setting name by _clazz and then value
  case 'Object'
     unpack-obj arg
  default
    throw new Error "Attribute must be named by a String or Object (with _clazz), was: #{arg} [#{typeof arg}]"

unpack-obj = (obj) ->
  if obj._clazz
    throw new Error "Unable to create Attribute from, #{util.inspect obj} with class: #{obj._clazz}"
  else
    key = _.keys(obj).first!
    # detect if constructed from arguments hash
    if key is '0'
      throw new Error "Bad arguments: #{util.inspect obj}"
    # allow customizing attribute name
    # admin: user-obj
    [key, _.values(obj).first!]

# Must be on a model
AttributePipe = new Class(BasePipe,
  initialize: (arg) ->
    console.log 'attr pipe arg', arg
    if _.is-type 'Array', arg
      throw new Error "AttributePipe cannot be constructed from an Array, was: #{arg}"

    @call-super!

    console.log 'type', typeof! arg
    [@name, @value] = unpack arg
    console.log 'post init', @name
    @post-init!
    console.log 'return AttributePipe'
    @

  pipe-type: 'Attribute'

  id: ->
    @name

  # should be the end of the line!!!
  # only simple values can go here, no models or collections!
  # attach: void

)

module.exports = AttributePipe