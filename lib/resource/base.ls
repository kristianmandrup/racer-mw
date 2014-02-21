Class       = require('jsclass/src/core').Class

require = require '../../requires'

BaseResource = new Class(
  initialize: ->
    # should use path to always pre-resolve scope
    @scoped 'path'

  commands:
    * 'at'
    * 'scope'
    * 'parent'
    * 'path'
    * 'leaf'

  save: ->
    @set @value-object

)