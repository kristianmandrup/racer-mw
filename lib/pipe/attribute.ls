Class       = require('jsclass/src/core').Class

requires = require '../../requires'

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'

BasePipe          = requires.pipe 'base'

# Must be on a model
AttributePipe = new Class(BasePipe,
  initialize: (arg) ->
    if _.is-type 'Array', arg
      throw new Error "AttributePipe cannot be constructed from an Array, was: #{arg}"
    @call-super!

    switch typeof arg
    case 'string'
      @name = arg
    # allow object, setting name by _clazz and then value
    case 'object'
      obj = arg

      if obj._clazz
        new ModelPipe obj
      else
        key = _.keys(obj).first!
        # detect if constructed from arguments hash
        if key is '0'
          throw new Error "Bad arguments: #{util.inspect obj}"
        # allow customizing attribute name
        # admin: user-obj
        @name = key
        @value = _.values(obj).first!
    default
      throw new Error "Attribute must be named by a String or Object (with _clazz), was: #{arg} [#{typeof arg}]"
    @post-init!
    @


  pipe-type: 'Attribute'

  id: ->
    @name

  # should be the end of the line!!!
  # only simple values can go here, no models or collections!
  attach: void

)

module.exports = AttributePipe