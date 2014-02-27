Class       = require('jsclass/src/core').Class
requires    = require '../../requires'

ResourceCommand   = requires.resource 'command'

BaseResource = new Class(ResourceCommand,
  # created with a Pipe
  initialize: (@pipe) ->
    unless typeof! @pipe is 'Object' and @pipe.type is 'Pipe'
      throw new Error "a Resource must be created with a Pipe, was: #{@pipe}"

    @call-super @pipe
    @pipe.$res = @
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