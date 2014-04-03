Class       = require('jsclass/src/core').Class
get = require '../../../requires' .get!
_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

ModelPipe               = get.apipe 'model'

# Must be on a model or attribute
CollectionModelPipe = new Class(ModelPipe,
  initialize: (item) ->
    try
      @call-super!
      @set @first-arg
      @post-init!
    finally
      @

  pipe:
    type:       \CollectionModel
    base-type:  \Model

  id: ->
    String(@object-id) unless @object-id is void

  pre-attach-to: (parent) ->
    @call-super!
    @attacher!.attach-to parent

  attacher: ->
    new ParentAttacher @

  valid-parents:  <[path collection]>
  valid-children: <[attribute model-attribute collection]>
)

module.exports = ModelPipe