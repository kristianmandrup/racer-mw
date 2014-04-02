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
    return unless @parent-name and _.is-type 'Function', @parent-name

    names = [@parent-name!, @name].exclude (name) ->
      name is void or _.empty(name)
    @full-name = names.join '.'
)

module.exports = PipeIdentifier