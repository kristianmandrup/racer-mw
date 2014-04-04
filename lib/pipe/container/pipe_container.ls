# Family methods to access child pipes etc.


PipeContainer = new Module(
  allow-children: true

  has-children: ->
    @child-count > 0

  no-children: ->
    not @has-children!

  child-hash: {}

  child-names: ->
    _.keys(@child-hash)

  child: (name) ->
    unless @child-hash[name] then
      throw new Error "Pipe has no named: #{name}"
    @child-hash[name]

  remove-child: (name) ->
    removed = lo.extend {}, @child-hash[name]
    removed.parent = void
    delete @child-hash[name]
    @update-child-count!
    removed

  add-child: (name, pipe) ->
    @validate-child name pipe
    pipe.parent = @
    @child-hash[name] = pipe
    @update-child-count!

  validate-child: (name, pipe) ->
    unless _.is-type 'String', name
      throw new Error "Name of pipe added must be a String, was: #{name}"

    unless _.is-type 'Object', pipe
      throw new Error "Pipe added as child must be an Object, was: #{pipe}"

    unless @has-children
      throw new Error "This pipe does not allow child pipes"

  update-child-count: ->
    @child-count = @child-names!.length

  child-count: 0

  child-list: ->
    _.values(@child-hash).compact!

  child-type: (name) ->
    @child(name).pipe.type

  children-types: ->
    lo.map @child-names, @child-type, @
)

module.exports = PipeContainer