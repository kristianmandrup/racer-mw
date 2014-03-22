Class       = require('jsclass/src/core').Class

requires  = require '../../requires'

_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

BasePipe          = requires.apipe 'base'
PathPipe          = requires.apipe 'path'

ModelsPipeBuilder = requires.apipe-builder 'models'

col-name = (arg) ->
  switch typeof arg
  case 'string'
    arg
  case 'object'
    unless arg._clazz
      throw new Error "Object passed must have a _clazz attribute, was: #{util.inspect arg} [#{typeof arg}]"
    arg._clazz
  default
    throw new Error "CollectionPipe constructor must take a String or Object as argument, was: #{arg} [#{typeof arg}]"

attach-to-path-pipe = (names, col-pipe) ->
  path-pipe = new PathPipe(names)
  path-pipe.attach col-pipe

# Must be on a model or attribute
CollectionPipe = new Class(BasePipe,
  initialize: ->
    @call-super!

    name = @args
    if _.is-type('Array', @args) and @args.length > 1
      name = @config-via-array!

    if _.is-type('Object', @args)
      name = _.keys(@args).first!
      value = _.values(@args).first!

    # set name of collection :)
    @set-name col-name(name).pluralize!
    @post-init!
    @

  set-value: (value) ->
    builder = if _.is-type('Array', value) then @models else @model
    builder value

  get-value: ->
    _.values(@children).map (child) ->
      child.value!

  config-via-array: ->
    attach-to-path-pipe @args[0 to -2], @
    @args.last!

  pipe-type: 'Collection'

  next-child-id: ->
    keys = _.keys(@children)
    keys.length

  id: ->
    @name

  valid-parents:
    * \path
    * \model # collection then becomes as an attribute on the model

  valid-children:
    * \model
)

module.exports = CollectionPipe