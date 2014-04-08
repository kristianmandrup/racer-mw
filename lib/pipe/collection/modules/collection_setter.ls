Class       = require('jsclass/src/core').Class

requires    = require '../../../../requires'

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'

BaseSetter = requires.pipe 'base/setter'

CollectionSetter = new Module(BaseSetter,
  initialize: (@arg) ->
    @

  set-all: ->
    @set-name!
    @set-value!
)

module.exports = CollectionSetter