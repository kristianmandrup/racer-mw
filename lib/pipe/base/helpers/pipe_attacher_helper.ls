# TODO: Refactor and simplify!
PipeAttachBaseHelper = new Class(
  attach-to: (parent) ->
    @parent-validator(parent).validate @
    @validate-id!

    @pre-attach-to parent

    parent.add-child @id!, @
    @attached-to parent

    @post-attach-to parent
    @

  # should only be when adding CollectionModels to Collection!?
  validate-id: ->
    unless @id!
      throw new Error "id function of #{@pipe-type} Pipe returns invalid id: #{@id!}"

  pre-attach-to: (parent) ->
    @validate-attach parent

  attached-to: (parent) ->
    # update full-name
    @update-name!
    @update-child-names!
    parent.added = @ if parent
    @

  update-child-names: ->
    for k, v of @child-hash
      @child-hash[k].update-name!

  parent-validator: (parent) ->
    new ParentValidator(parent).set-valid @valid-parents

  # throw new Error if invalid pipe for parent
  validate-attach: (parent) ->

  post-attach-to: (parent) ->
)

PipeAttachHelper = new Class(PipeAttachBaseHelper,
  # when attached, a pipe should update its cached full-name
  attach: (pipe) ->

  attach-list: (pipes) ->
    @validate-pipes pipes
    self = @
    lo.each pipes @attach
    @

  validate-pipes: (pipes) ->
    unless typeof! pipes is 'Array'
      throw new Error "Can only attach to a list of Pipes, was: #{typeof! pipes}"

)

PipeDetachHelper = new Class(PipeAttachBaseHelper,
  detach: ->
    @parent = void
    @attached-to!
    @
)

module.exports =
  attach: PipeAttachHelper
  detach: PipeDetachHelper