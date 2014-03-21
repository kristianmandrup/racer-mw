/**
 * User: kmandrup
 * Date: 08/03/14
 * Time: 17:04
 */
Module       = require('jsclass/src/core').Module

requires  = require '../../requires'

_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

PipeResource = new Module(

  # by default any pipe can have a resource (except PathPipe)
  has-resource: true

  # to create and set resource of pipe
  create-res: ->
    return unless @has-resource
    unless _.is-type 'String', @pipe-type
      throw new Error "Pipe must have a pipe-type to know what resource to create"

    resource-clazz = requires.aresource(@pipe-type.to-lower-case!)
    @$res = new resource-clazz pipe: @
)

module.exports = PipeResource