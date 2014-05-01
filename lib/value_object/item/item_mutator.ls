Class   = require('jsclass/src/core').Class
get     = require '../../../requires' .get!
Parser  = get.pipe-parser 'base'

ItemMutator = new Class(
  initialize: (@container, @list) ->
    throw new Error "Must take a container Object for the list" unless typeof! @container is 'Object'
    @

  new-item: ->
    if @list.length >= @index then @list[@index] else void

  item: ->
    @parser!.build-model @new-item!

  parser: ->
    @_parser ||= new Parser
)

module.exports = ItemMutator