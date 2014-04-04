Module    = require('jsclass/src/core').Module

ChildStats = new Module(
  child-hash: {}

  has-children: ->
    @child-count > 0

  no-children: ->
    not @has-children!

  child-names: ->
    _.keys(@child-hash)

  child-count: 0

  child-list: ->
    _.values(@child-hash).compact!

  child-type: (name) ->
    @child(name).pipe.type

  children-types: ->
    lo.map @child-names, @child-type, @
)

module.exports = ChildStats