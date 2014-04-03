Module    = require('jsclass/src/core').Module
_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

PipeArgValidation = new Module(
  validate-args: ->
    @validate-first-arg!
    unless argumentor.validate @args, @valid-args
      throw new Error "Pipe init argument #{@args} [#{typeof @args}] is not valid, must be one of: #{@valid-args}"

  validate-first-arg: ->
    switch typeof! @first-arg
    case 'Number'
      throw new Error "First arg can not be a Number, was: #{@first-arg}"
    case 'Function'
      throw new Error "First arg can not be a Function"
)

module.exports = PipeArgValidation