Class       = require('jsclass/src/core').Class
requires    = require '../../requires'

_   = require 'prelude-ls'
lo  = require 'lodash'
util = require 'util'
require 'sugar'

ResourceCommand   = requires.resource 'resource_command'

ResourceAttacher  = requires.resource 'resource_attacher'
ResourceValue     = requires.resource 'resource_value'

BaseResource = new Class(ResourceCommand,
  include:
    * ResourceValue
    * ResourceAttacher

  # created with a Pipe
  initialize: (context) ->
    unless typeof! context is 'Object'
      throw Error "A resource must be constructed with a context Object, was: #{util.inspect context}"
    @set-value context.value

    # transfer pipe value if no value set for context and transfer = true
    transfer = if context.value isnt void then false else context.transfer

    @attach-to context.pipe, transfer: transfer

    @call-super @

  resource-type: 'Base'

  pipe: void

  # use pipe path if there
  path: ->
    return @pipe.path if @pipe
    @full-path unless @full-path is void

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