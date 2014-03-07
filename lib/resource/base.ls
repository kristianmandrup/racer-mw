Class       = require('jsclass/src/core').Class
requires    = require '../../requires'

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

ResourceCommand   = requires.resource 'command'

BaseResource = new Class(ResourceCommand,
  # created with a Pipe
  initialize: (context) ->
    unless typeof! context is 'Object'
      throw Error "A resource must be constructed with a context Object, was: #{context}"

    @attach-to context.pipe
    @config-value context.value

    @call-super @

    # should use Pipe path to always pre-resolve scope
    # @scoped 'path'

  config-value: (value) ->
    @value = value

  # Design note:
  # should it copy the value from the pipe before detaching if
  # the resource doesn't have its own value?
  detach: (hash)->
    @transfer-pipe-value hash
    @pipe = void

  transfer-pipe-value: (hash) ->
    if @value is void and _.is-type('Object', hash)
      @value = @pipe-value! if hash.transfer

  attach-to: (pipe, hash)->
    return unless pipe
    unless typeof! pipe is 'Object' and pipe.type is 'Pipe'
      throw new Error "a Resource can only be attached to a Pipe, was: #{pipe}"

    unless @resource-type is pipe.pipe-type
      throw new Error "A #{@resource-type} Resource can only be attached to a #{@resource-type} Pipe, was a #{pipe.pipe-type} pipe"

    @pipe = pipe
    @transfer-pipe-value hash

    # set $resource of pipe
    # but only for those pipes that allow a resource!
    if @pipe.has-resource
      @pipe.$resource = @

  resource-type: 'Base'

  pipe: void

  # use pipe path if there
  path: ->
    return @pipe.path if @pipe
    @full-path unless @full-path is void

  value-object: ->
    return @value unless @value is void
    return @pipe-value! unless @pipe-value! is void
    pipe-error = if @pipe then "or its pipe" else ''
    throw new Error "No value set for this resource #{pipe-error}"

  pipe-value: ->
    return unless @pipe
    valo = @pipe.get-value!
    return valo if valo isnt void
    @pipe.value if @pipe.value isnt void

  commands:
    basic:
      * 'at'
      * 'scope'
      * 'parent'
      * 'path'
      * 'leaf'

  save: ->
    @set @value-object!
)

module.exports = BaseResource