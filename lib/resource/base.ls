Class       = require('jsclass/src/core').Class
requires    = require '../../requires'

ResourceCommand   = requires.resource 'command'

BaseResource = new Class(ResourceCommand,
  # created with a Pipe
  initialize: (@pipe) ->
    @call-super @pipe
    # should use Pipe path to always pre-resolve scope
    # @scoped 'path'

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