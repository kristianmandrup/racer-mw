Module       = require('jsclass/src/core').Module

_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'

requires  = require '../../requires'

ValueObject = requires.lib 'value_object'

ResourceAttacher = new Module(
  # Design note:
  # should it copy the value from the pipe before detaching if
  # the resource doesn't have its own value?
  detach: (hash)->
    val = @transfer-pipe-value hash
    @pipe = void
    val

  attach-to: (pipe, hash = {})->
    return unless pipe
    unless typeof! pipe is 'Object' and pipe.type is 'Pipe'
      throw new Error "a Resource can only be attached to a Pipe, was: #{util.inspect pipe}, type: #{pipe.type}"

    unless @resource-type is pipe.pipe-type
      throw new Error "A #{@resource-type} Resource can only be attached to a #{@resource-type} Pipe, was a #{pipe.pipe-type} pipe"

    @pipe = pipe
    val = @transfer-pipe-value hash

    # set $resource of pipe
    # but only for those pipes that allow a resource!
    if @pipe.has-resource
      @pipe.$resource = @

  transfer-pipe-value: (hash = {}) ->
    if @should-transfer hash
      @value-obj = new ValueObject @, value: @pipe.value!
      return @value-obj.value
    void

  should-transfer: (hash = {}) ->
    hash.transfer is true
)

module.exports = ResourceAttacher