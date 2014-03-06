Class       = require('jsclass/src/core').Class

requires  = require '../../requires'

_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

BasePipe          = requires.pipe 'base'
PathPipe          = requires.pipe 'path'
ColModelPipe      = requires.pipe 'col_model'
ModelsPipe        = requires.pipe 'models'

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

ColModelPipe    = requires.pipe 'col_model'

# Must be on a model or attribute
CollectionPipe = new Class(BasePipe,
  initialize: ->
    @call-super!

    if _.is-type('Array', @args) and @args.length > 1
      name = @args.last!
    else
      name = @args

    # set name of collection :)
    @set-name col-name(name).pluralize!

    if _.is-type('Array', @args) and @args.length > 1
      path-names = @args[0 to -2]
      attach-to-path-pipe path-names, @

    @post-init!
    @

  pipe-type: 'Collection'

  next-child-id: ->
    _.keys(@children).length + 1

  id: ->
    @name

  # pipe builder
  # attach a model pipe as a child
  # return model pipe for more chaining
  model: (obj) ->
    console.log 'obj' obj
    pipe = new ColModelPipe(obj)
    console.log 'pipe', pipe
    @attach pipe
    pipe

  models: ->
    new ModelsPipe @

  valid-parents:
    * 'path'
    * 'model' # collection then becomes as an attribute on the model
)

module.exports = CollectionPipe