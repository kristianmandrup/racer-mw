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
    @set-res!

  set-res: ->
    @$res = new @resource-clazz! pipe: @ if @has-resource!

  resource-clazz: ->
    @res-clazz ||= get.aresource @pipe-type.to-lower-case!
)

module.exports = PipeResource