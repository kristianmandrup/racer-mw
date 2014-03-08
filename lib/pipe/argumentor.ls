_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'


# used by BasePipe to extract and validate args
module.exports =
  # [@first-arg, @args] = argumentor.extract arguments
  extract: ->
    list = _.values(arguments).flatten!
    switch list.length
    case 0
      throw new Error "Pipe constructor must always take at least one argument"
    case 1
      first-arg = list.first!
      [first-arg, first-arg]
    else
      [list.first!, list].compact!

  # For any pipe you can use valid-args to declare which arguments are valid for init
  # unless argumentor.validate @args, @valid-args
  #  ...
  validate: (args, valid-args)->
    unless args
      throw new Error "Pipe must take a value to help it determine a path in the model"

    return true if valid-args.length is 0
    valid-args = args.select (arg) ->
      typeof(arg) in valid-args
    valid-args.length is args.length
