Class       = require('jsclass/src/core').Class

requires = require '../../requires'

_   = require 'prelude-ls'
lo  = require 'lodash'
require 'sugar'

BasePipe          = requires.pipe 'base'

# Must be on a model or attribute
# Useful to set initial model path containers such as '_session' or '_page' etc.
PathPipe = new Class(BasePipe,
  initialize: ->
    @call-super!

    if _.is-type 'Array', @args
      @name = @args.join '.'
    else if _.is-type 'String', @args
      @name = @args
    else
      throw new Error "Invalid name argument(s) for PathPipe: #{@args}"
    delete @args
    @

  pipe-type: 'Path'

  id: ->
    @name

  valid-args:
    * 'string'

  valid-parents:
    * 'container'
    # * 'model' # makes sense here?
)

module.exports = PathPipe