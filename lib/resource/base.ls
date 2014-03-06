Class       = require('jsclass/src/core').Class
requires    = require '../../requires'

ResourceCommand   = requires.resource 'command'

BaseResource = new Class(ResourceCommand,
  # created with a Pipe
  initialize: (context) ->
    unless typeof! context is 'Object'
      throw Error "A resource must be constructed with a context Object, was: #{context}"

    @config-pipe context.pipe
    @config-value context.value

    @call-super @

    # should use Pipe path to always pre-resolve scope
    # @scoped 'path'

  config-value: (value) ->
    @value = value

  config-pipe: (pipe) ->
    return unless pipe
    unless typeof! pipe is 'Object' and pipe.type is 'Pipe'
      throw new Error "a Resource must be created with a Pipe, was: #{pipe}"

    @pipe = pipe

    # set reference to pipe on $res and $resource
    # only for those pipes that allow a resource!
    if @pipe.has-resource
      @pipe.$resource = @

  detach: ->
    @pipe = void

  resource-type: 'Base'

  pipe: void

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