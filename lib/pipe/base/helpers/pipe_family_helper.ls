Module    = require('jsclass/src/core').Module
get       = require '../../../../requires' .get!
_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

BaseGetter = new Class(
  initialize: (@pipe) ->
    @clear!
    @

  get: (@name) ->
    @child!

  child: ->
    @pipe.child @name if @validate!

  validate: ->
    unless @is-valid-type!
      throw new Error "The child pipe #{@name} is not a #{@valid-type}"

  valid-type: void

  is-valid-type: ->
    @type! is @valid-type

  type: ->
    @pipe.pipe.type
)

AttributeGetter = new Class(BaseGetter,
  valid-type: 'Attribute'
)

ModelGetter = new Class(BaseGetter,
  valid-type: 'Model'
)

CollectionGetter = new Class(BaseGetter,
  valid-type: 'Collection'
)

module.exports =
  attribute:    AttributeGetter
  model:        ModelGetter
  collection:   CollectionGetter
