requires = require '../../../requires'

Class       = require('jsclass/src/core').Class

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'

BaseParser  = requires.pipe 'parser/base_parser'
ListParser  = requires.pipe 'parser/list_parser'
PathPipe    = requires.apipe 'path'

ObjectParser = new Class(BaseParser,
  initialize: (@parser, @value, options = {}) ->
    @call-super!
    @list-parser = new ListParser(@parser)
    @

  parse: (obj) ->
    @debug-msg "parse-object #{util.inspect obj}"
    self = this
    keys = _.keys(obj)
    return [] if keys.length is 0
    mapped = keys.map (key) ->
      value = obj[key]
      self.parse-tupel key, value
    if mapped.length is 1 then mapped.first! else mapped


)

module.exports = ObjectParser