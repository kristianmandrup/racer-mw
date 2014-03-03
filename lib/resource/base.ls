Class       = require('jsclass/src/core').Class
requires    = require '../../requires'

ResourceCommand   = requires.resource 'command'

BaseResource = new Class(ResourceCommand,
  # created with a Pipe
  initialize: (context) ->
    unless typeof! context is 'Object'
      throw Error "A resource must be constructed with a context Object, was: #{context}"

    pipe = context.pipe
    unless typeof! pipe is 'Object' and pipe.type is 'Pipe'
      throw new Error "a Resource must be created with a Pipe, was: #{pipe}"
    @pipe = pipe

    @call-super @pipe

    # set reference to pipe on $res and $resource
    # only for those pipes that allow a resource!
    if @pipe.has-resource
      @pipe.$res = @
      @pipe.$resource = @

    # should use Pipe path to always pre-resolve scope
    # @scoped 'path'

  resource-type: 'Base'

  pipe: void

  commands:
    basic:
      * 'at'
      * 'scope'
      * 'parent'
      * 'path'
      * 'leaf'

  save: ->
    @set @value-object
)

module.exports = BaseResource