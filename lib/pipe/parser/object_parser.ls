requires = require '../../../requires'

Class       = require('jsclass/src/core').Class

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'

BaseParser = requires.pipe 'parser/base_parser'

ObjectParser = new Class(
  initialize: (@parser) ->
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

  parse-single: (key, value) ->
    unless _.is-type 'String', key
      throw new Error "Key must be a String, was: #{typeof! key}, #{util.inspect key}"

    @debug-msg "parse-single #{key} #{value}"
    switch typeof! value
    case 'Object'
      @build 'model', value, key
    case 'String', 'Number'
      @build 'attribute', value, key
    case 'Undefined'
      @build 'model' key
    default
      throw new Error "Single value for #{key} should be Object, Number or String, was: #{typeof! value}, #{value}"

  # test if value is list of Object or list of simple types
  # if mixed, throw error
  list-type: (key, value) ->
    return 'empty' if value is void
    unless _.is-type 'Array', value
      throw new Error "plural value #{key} must be an Array, was: #{typeof! value} #{util.inspect value}"
    return 'empty' if value.length is 0
    return 'collection' if all-objects value
    return 'array' if all-simple value
    'mixed'

    all-simple: ->
      value.every (item) ->
        _.is-type('String', item) or _.is-type('Number', item)

    all-objects: ->
      value.every (item) ->
        _.is-type 'Object', item

  parse-path: (key, value) ->
    @debug-msg "PathPipe: #{key}"
    path-pipe = new PathPipe key
    @build-children value, path-pipe

  parse-tupel: (key, value) ->
    @debug-msg "parse-tupel #{key}, #{value}"
    return @list-parser.parse-plural key, value if @tupel-type key is 'plural'

    method = @tupel-type key
    @["parse#{method}"] key, value

  tupel-type: (key) ->
    unless _.is-type 'String', key
      throw new Error "Key must be a String, was: #{typeof! key}, #{util.inspect key}"

    first-char = key[0]
    return 'Path' if first-char is '_' or first-char is '$'
    return 'Single' if key.singularize! is key
    return 'Plural' if key.pluralize! is key
    throw new Error "Can't determine tupel type from key: #{key}"
)

module.exports = ObjectParser