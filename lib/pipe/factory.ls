

PipeFactory = new Class(
  initialize: (@value-object, @options = {}) ->
  @type     = @options.type
  @parent   = @options.parent

  create-pipe: ->
    @value-object.$pipe = new Pipe(@value-object)
    @value-object.$p = Pipe.$p # from local Node module scope
    @value-object.$queries = new Queries(@value-object)

  set-mw: ->
    switch @type
    case 'model'
      return
    default
      @value-object.$resource.mw-stack.remove ['validator', 'authorizer']
)

module.exports = PipeFactory