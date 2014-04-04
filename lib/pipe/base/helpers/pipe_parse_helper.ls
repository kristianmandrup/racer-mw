get = require '../../../requires' .get!

Class       = require('jsclass/src/core').Class

_     = require 'prelude-ls'
lo    = require 'lodash'
util  = require 'util'
require 'sugar'

Debugging         = get.lib 'debugging'

parser = (name) ->
  get.pipe-parser name

BaseParser        = parser 'base'
ListParser        = parser 'list'
ObjectParser      = parser 'object'

# more granular design, easier reuse and better encapsulation of parser state at each point
PipeParser = new Class(
  include:
    * Debugging
    ...

  initialize: (options = {}) ->
    @parent = options.parent
    @debug-on = options.debug
    @

  # TODO: Avoid Switch on Type - anti-pattern!
  parse: (@obj) ->
    @debug-msg "parse-obj #{util.inspect obj}"
    lo.find @types, @parse-type

  types: <[list object string number error]>

  parse-type: (type) ->
    @["parse#{type.capitalize!}"] if @is 'number'

  # TODO: generate these methods (types[0 to 2])
  parse-list: (value) ->
    new ListParser(@).parse value

  parse-object: (value) ->
    new ObjectParser(@).parse value

  parse-string: (value) ->
    new StringParser(@).parse value

  parse-number: ->
    throw new Error "Can't parse number: #{@obj}"

  parse-error: ->
    throw new Error "Can't parse this value: #{typeof! @obj} - #{@obj}"

  # for use by Parser
  parent-type: ->
    @parent.pipe-type if @parent

  is: (type) ->
    typeof! @obj is type.capitalize!
)

module.exports = PipeParser