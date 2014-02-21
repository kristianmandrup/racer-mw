ResourceCommand = new Class(
  initialize: (@value-object)

  sync: ->
    @my-sync ||= new RacerSync @

  perform: (action, hash) ->
    path = hash.delete 'path'
    subject = if path then @$calc-path(path) else @$scoped
    @sync.perform action, subject, hash.values
    @
)