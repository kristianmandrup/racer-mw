Class       = require('jsclass/src/core').Class

requires  = require '../../requires'

_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

ContainerPipe     = requires.apipe 'container'
PathPipe          = requires.apipe 'path'

ModelsPipeBuilder = requires.apipe-builder 'models'

NameExtractor     = requires.pipe 'collection/name_extractor'

ArrayValueObject = requires.lib 'value_object/array_value_object'

# Must be on a model or attribute
CollectionPipe = new Class(ContainerPipe,
  # TODO: refactor!
  initialize: ->
    @call-super!
    # set name of collection :)
    @set-name @collection-name(@name)
    @post-init!
    @

  collection-name: ->
    @extract-name!
    new CollectionNameExtractor(@name).plural!


  # TODO: Clean up, extract, refactor!!
  # What about NameExtractor class!?
  /*
  extract-name: ->
    @name = @args
    @name-from-array! or @name-from-object!

  name-from-array: ->
    @name = @config-via-array! if @array-args!

  array-args: ->
    typeof! @args is 'Array' and @args.length > 1

  name-from-object: ->
    @name = _.keys(@args).first! if @object-args!

  value-from-object: ->
    @value = _.values(@args).first! if @object-args!

  object-args: ->
    typeof! @args is 'Object'
  */

  pipe:
    type:       'Collection'
    base-type:  'Collection'

  pipe-type: 'Collection'

  next-child-id: ->
    @child-count + 1

  id: ->
    @name

  valid-parents:  <[path attribute-model]>
  valid-children: <[collection-model]>
)

module.exports = CollectionPipe