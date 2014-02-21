Class     = require('jsclass/src/core').Class

Query     = requires.lib 'query'

BaseResource = new Class(
  # value-object
  initialize: (@value-object)

  sync: ->
    @my-sync ||= new RacerSync @

  perform: (action, hash) ->
    path = hash.delete 'path'
    subject = if path then @$calc-path(path) else @$scoped
    @sync.perform action, subject, hash.values
    @

  update-model: (live-obj) ->
    new LiveDecorator(@value-object).decorate live-obj

  mutate: (action, hash) ->
    @perform action, hash

  scoped: (action, hash) ->
    @$scoped = @perform action, hash
    @

  $scoped: void

  $save: ->
    @$set @value-object

  $set: ->
    switch arguments.length
    case 0
      @$set @value-object
    case 1
      @mutate 'set', arguments[0]
    case 2
      @mutate arguments[0], arguments[1]
    default
      throw Error "Too many arguments #{arguments.length}, must be 0-2 for $set"

  $set-null: (path) ->
    @mutate 'if-null', path: path

  # fn-name: optional
  $filter: (path, fn-name) ->
    @perform 'filter', path: path, name: fn-name

  # filter = model.sort ( inputPath, [name] )
  $sort: (path, fn-name) ->
    @perform 'sort', path: path, name: fn-name

  $subscribe: (cb, path) ->
    @perform 'subscribe', path: path, cb: cb

  $scope: (path)->
    @scoped 'scope', path: path

  $parent: (lvs)->
    @scoped 'parent', lvs: lvs

  $query: (collection, hash) ->
    unless typeof hash is 'object'
      throw Error "Must be an Object, was: #{hash}"

    hash = if hash.path then {path: hash.path} else {q: hash.q}
    query = @perform 'query', collection, hash
    new Query(@,  query)

  # model.ref path, to
  $ref: (path, hash)->
    @scoped 'ref', path: path, to: to

  $removeRef: (path) ->
    @perform 'removeRef', path: path

  $removeAllRefs: (path) ->
    @perform 'removeAllRefs', path: path

  $delete: (path) ->
    @perform 'del', path: path

  $get: (path) ->
    @perform 'get', path: path

  $at: (id) ->
    @id ||= id
    throw Error "Missing id" unless @id
    @scoped 'at', @id
)

module.exports = BaseResource