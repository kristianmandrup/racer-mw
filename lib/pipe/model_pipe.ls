Class       = require('jsclass/src/core').Class

requires = require '../../requires'

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

BasePipe                = requires.apipe 'base'

# Must be on a model or attribute
ModelPipe = new Class(BasePipe,
  initialize: ->
    try
      @call-super!
      @set @first-arg
      @post-init!
    finally
      @

  pipe-type: 'Model'

  id: ->
    throw new Error "Must be implemented by subclass"

  set: (obj) ->
    @set-class obj
    @set-name extract.name(obj, @clazz)
    @set-value extract.value(obj)

  set-class: (obj) ->
    @clazz = extract.clazz(obj)

  # don't use extract.value here!!
  set-value: (obj) ->
    @call-super obj

  pre-attach-to: (parent) ->
    @call-super!

  valid-parents: []

  valid-children: []
)

module.exports = ModelPipe