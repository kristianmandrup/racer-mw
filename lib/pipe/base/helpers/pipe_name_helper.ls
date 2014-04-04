Class     = require('jsclass/src/core').Class
get       = require '../../../../requires' .get!
_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

PipeNameHelper = new Class(
  initialize: (@pipe) ->
    @name = @pipe.name
    @

  full-name: ->
    @names!.join '.'

  names: ->
    [@valid-parent-name!, @name].compact!

  parent-name: ->
    @pipe.parent-name!
)

module.exports = PipeNameHelper