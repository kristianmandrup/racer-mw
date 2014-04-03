Class       = require('jsclass/src/core').Class
get = require '../../../requires' .get!
_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

ModelPipe               = get.apipe 'model'
ParentAttacher          = void

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
    type: \CollectionModel
    container:  true
    child:      true
    named:      false
    kind: \Model

  id: ->
    String(@object-id) unless @object-id is void

  attacher: ->
    new ParentAttacher @

  valid-parents:
    type: \collection

  valid-children:
    kind: \named
)

module.exports = ModelPipe