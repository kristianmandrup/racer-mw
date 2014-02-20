Class       = require('jsclass/src/core').Class

require = require '../../requires'

requires.resource 'base'

AttributeResource = new Class(BaseResource,
  # value-object
  initialize: (@value-object)

  sync: ->
    @my-sync ||= new RacerSync @

  perform: (action, path, args) ->
    subject = if path then @$calc-path(path) else @$scoped
    @sync.perform action, subject, args
    update-model: (live-obj) ->
      new LiveDecorator(@value-object).decorate live-obj

  $save: ->
    @$set @value-object

  $set: ->
    @$scoped = switch arguments.length
    case 0
      @$set @value-object
    case 1
      @perform 'set', arguments[0]
    case 2
      vhash = {}
      vhash[arguments[0]] = arguments[1]
      @$set vhash
    default
      throw Error "Too many arguments #{arguments.length}, must be 0-2 for $set"

  $push: (path) ->
    @perform 'push', path

  $set-null: (path) ->
    @perform 'if-null', path

  $inc: (path) ->
    @perform 'increment', path

  $alive: void
  $scoped: void

  $subscribe: (cb, path) ->
    @perform 'subscribe', path, cb

  # model.ref path, to
  $live: (path)->
      $alive = @perform 'ref', path
      @update-model($alive)

  $remove-live: (path) ->
    $alive = @perform 'refRemove', path

  $delete: (path) ->
    @perform 'del', path

  $get: (path) ->
    @perform 'get', path

  $at: (id) ->
    @id ||= id
    throw Error "No id set for #{@collection}" unless @id
    @$scoped = @perform 'at', @id
)

module.exports = AttributeResource