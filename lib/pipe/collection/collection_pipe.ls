Class = require('jsclass/src/core').Class
get   = require '../../../requires' .get!

_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

BasePipe          = get.apipe                 'base'
NamedPipe         = get.apipe                 'named'
ChildPipe         = get.apipe                 'child'
ContainerPipe     = get.apipe                 'container'
PathPipe          = get.apipe                 'path'

ModelsPipeBuilder = get.model-builder         'models'
NameExtractor     = get.collection-extractor  'name'
ArrayValueObject  = get.value-object          'array'

CollectionPipe = new Class(BasePipe,
  include:
    * ContainerPipe
    * ChildPipe
    * NamedPipe
    ...

  initialize: ->
    @call-super!
    @

  collection-name: ->
    @extract-name!
    new CollectionNameExtractor(@name).plural!

  # other values set dynamically by pipe modules!
  pipe:
    type:       'Collection'
    base-type:  'Collection'

  next-child-id: ->
    @child-count + 1

  id: ->
    @name


  valid-parents:
    kind: \model

  valid-children: <[ collection-model ]>
)

module.exports = CollectionPipe