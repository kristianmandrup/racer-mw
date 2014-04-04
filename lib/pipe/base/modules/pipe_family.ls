Module    = require('jsclass/src/core').Module
get       = require '../../../../requires' .get!
_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'


FamilyAttribute = new Module(
  attr: (name) ->
    new AttributeGetter(@).get name
)

FamilyModel = new Module(
  modl: (name) ->
    new ModelGetter(@).get name
)

FamilyCollection = new Module(
  col: (name) ->
    new CollectionGetter(@).get name
)


module.exports =
  attribute:  FamilyAttribute
  model:      FamilyModel
  collection: FamilyCollection

