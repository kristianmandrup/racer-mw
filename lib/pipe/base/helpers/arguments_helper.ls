Class       = require('jsclass/src/core').Class
_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

# used by BasePipe to extract and validate args
PipeArgumentsHelper = new Class(
  initialize: (...@args) ->
    @

  extract: ->
    @empty(@args) or [@args.pop!, @args].compact!

  empty: ->
    if lo.is-emty @args
      throw new Error "Pipe constructor must always take at least one argument"

  # For any pipe you can use valid-args to declare which arguments are valid for initializing pipe
  validate: (@valid-args)->
    @valid-args! and @filtered!.length is @args.length

  valid-args: ->
    unless @args
      throw new Error "Pipe must take a value to help it determine a path in the model"
    true

  filtered:  ->
    lo.filter @args, @valid-type, @

  valid-type: (arg) ->
    typeof arg in @valid-args

)

module.exports = PipeArgumentsHelper

