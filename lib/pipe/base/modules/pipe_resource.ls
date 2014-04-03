Module    = require('jsclass/src/core').Module
get       = require '../../../../requires' .get!
_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

PipeResource = new Module(
  # by default any pipe can have a resource (except PathPipe)
  has-resource: true

  # to create and set resource of pipe
  create-res: ->
    return unless @has-resource!
    @validate-string!
    @resource-clazz!
    @set-res!

  set-res: ->
    @$res = new @clazz pipe: @

  resource-clazz: ->
    @res-clazz ||= get.aresource @pipe-type.to-lower-case!

  validate-string: ->
    unless typeof! @pipe-type is 'String'
      throw new Error "Pipe must have a pipe-type to know what resource to create"

)

module.exports = PipeResource