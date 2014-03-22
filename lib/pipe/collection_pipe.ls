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

  # TODO: so far only works when setting with values where children already there...
  set-value: (value) ->
    @call-super value
    # depends on whether one or more of the children the match the Array are already there

    # builder = @builder-for(value)
    # builder.build value
    # @raw-value!

  post-set-value: (value)->
    @build-children value

  # Array
  build-children: (value) ->
    console.log 'build-children - NOT yet implemented'
    # for each item compare with current value
    # if different, create new ModelPipe and overwrite
    # else skip

    # if more items than original array, create and insert new children by parsing
    # if less items than original, either: remove remaining children or return? take extra options param?
    # to contract value if this array smaller than current

    # set-value [x, y, z], contract: true
    # to only overwrite 3 first but ignore the rest
    # set-value [x, y, z]

    # insert lists at specific positions
    # set-value-at 3: [x, y, z], 6: [a, b]


  builder-for: (value) ->
    @builder(@builder-name value)

  builder-name: (value) ->
    return 'models' if _.is-type('Array', value)
    'model'

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