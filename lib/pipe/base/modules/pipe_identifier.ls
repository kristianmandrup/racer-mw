Module  = require('jsclass/src/core').Module
get     = require '../../../../requires' .get!

PipeNameHelper  = get.base-helper 'name'

PipeIdentifier = new Module(
  set-name: (name) ->
    @name = name
    @update-full-name!
    @name

  id: ->
    throw new Error "A subclass of Pipe must implement id function"

  update-full-name: ->
    @full-name = @name-helper.full-name! if @parent

  name-helper: ->
    new PipeNameHelper @
)

module.exports = PipeIdentifier