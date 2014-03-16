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
  case 'Array'
     unpack-obj (arg.first!): arg.last!
  default
    throw new Error "Attribute must be named by a String or Object (with _clazz), was: #{arg} [#{typeof arg}]"

unpack-obj = (obj) ->
  if obj._clazz
    throw new Error "Unable to create Attribute from, #{util.inspect obj} with class: #{obj._clazz}"
  else
    key = _.keys(obj).first!
    # detect if arguments hash
    if key is '0'
      throw new Error "Bad arguments: #{util.inspect obj}"
    # allow customizing attribute name
    # admin: user-obj
    [key, _.values(obj).first!]

# Must be on a model or path pipe
AttributePipe = new Class(BasePipe,
  initialize: ->
    @call-super!
    [name, value] = unpack @args
    @set-name name
    @set-value value
    @post-init!
    @

  pipe-type: 'Attribute'

  id: ->
    @name

  # should be the end of the line!!!
  # only simple values can go here, no models or collections!
  # attach: void

)

module.exports = AttributePipe