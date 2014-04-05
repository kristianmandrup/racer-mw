Class     = require('jsclass/src/core').Class
get       = require '../../../../requires' .get!
require 'sugar'

PipeValidation = get.base-module 'validation'

PipeNameHelper = new Class(
  include: PipeValidation

  initialize: (@pipe) ->
    @is-pipe pipe
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