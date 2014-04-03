/**
 * User: kmandrup
 * Date: 08/03/14
 * Time: 16:59
 */
Module       = require('jsclass/src/core').Module

# requires  = require '../../../../requires'

_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

PipeIdentifier = new Module(
  set-name: (name) ->
    @name = name
    @update-name!
    @name

  id: ->
    throw new Error "A subclass of Pipe must implement id function"

  update-name: ->
    @set-full-name!

  set-full-name: ->
    @full-name = @names.join '.'

  names: ->
    [@valid-parent-name!, @name].compact!

  valid-parent-name: ->
    @parent-name! if @has-parent-name!

  has-parent-name: ->
    typeof! @parent-name is 'Function'
)

module.exports = PipeIdentifier