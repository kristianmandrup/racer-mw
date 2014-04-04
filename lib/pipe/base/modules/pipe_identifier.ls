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
    @update-full-name!
    @name

  id: ->
    throw new Error "A subclass of Pipe must implement id function"

  update-full-name: ->
    @full-name = @name-helper.full-name!

  name-helper: ->
    new PipeNameHelper @
)

module.exports = PipeIdentifier