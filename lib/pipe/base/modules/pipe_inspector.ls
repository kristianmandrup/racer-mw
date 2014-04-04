Module       = require('jsclass/src/core').Module

# requires  = require '../../../../requires'

_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

PipeInspector = new Module(
  describe-child: (name) ->
    @child(name).describe recursive

  describe: (children) ->
    type: @pipe.type
    name: @name
    id: @id! if @id
    value: util.inspect @value!
    children: @child-describer!display children

  child-describer: ->
    @_child-describer ||= new PipeChildDecribeHelper @
)

module.exports = PipeInspector