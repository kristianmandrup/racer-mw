Class       = require('jsclass/src/core').Class
requires    = require '../../requires'

ResourceCommand   = requires.resource 'command'

BaseResource = new Class(ResourceCommand,
  initialize: ->
    @call-super @
    # should use path to always pre-resolve scope
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