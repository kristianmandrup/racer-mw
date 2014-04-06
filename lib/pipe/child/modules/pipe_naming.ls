Module  = require('jsclass/src/core').Module
get     = require '../../../../requires' .get!

PipeNameHelper  = get.base-helper 'name'

PipeNamer = new Module(
  set-name: (name) ->
    @call-super!
    @update-full-name! if @parent
    @name

  id: ->
    throw new Error "A subclass of Pipe must implement id function"

  update-full-name: ->
    @full-name = @name-helper.full-name!

  name-helper: ->
    new PipeNameHelper @
)

module.exports = PipeNamer