_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

# used by BasePipe to extract and validate args
PipeArgumentor = new Class(
  initialize: (...@args) ->

  # [@first-arg, @args] = argumentor.extract arguments
  extract: ->
    @empty(@args) or [@args.pop!, @args].compact!

  empty: ->
    if lo.is-emty @args
      throw new Error "Pipe constructor must always take at least one argument"

  # For any pipe you can use valid-args to declare which arguments are valid for init
  # unless argumentor.validate @args, @valid-args
  #  ...
  validate: (@valid-args)->
    @validate-args!
    return true if @valid-args.length is 0
    @filtered!.length is @args.length

  validate-args: ->
    unless @args
      throw new Error "Pipe must take a value to help it determine a path in the model"

    unless typeof! @args is 'Array'
      throw new Error "Pipe argument must be an Array, was: #{typeof! @args}"

  filtered:  ->
    lo.filter @args, @valid-type, @

  valid-type: (arg) ->
    typeof arg in @valid-args

)

