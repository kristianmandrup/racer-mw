require 'sugar'

# should contain the main GLOBAL DSL methods that are exported

module.exports =
  # Pipe methods that can be used to start a new pipe!

  collection: (name) ->
    ColPipe = requires.pipe('collection')
    new ColPipe(name)

  # TODO: Refactor
  model: (obj) ->
    unless typeof obj is 'object'
      throw new Error "Invalid Model pipe argument. Must be an object, was: #{obj}"
    if obj._clazz
      col-pipe = @collection obj._clazz.pluralize!
      col-pipe.model obj
    else
      throw new Error "Object must have _clazz attribute, was: #{obj}"

  path: (name) ->
    PathPipe = requires.pipe 'path'
    new PathPipe(name)