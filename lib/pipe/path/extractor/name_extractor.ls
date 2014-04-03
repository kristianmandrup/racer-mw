Class       = require('jsclass/src/core').Class

BaseNameExtractor = requires.pipe!base!extractor!named 'base'

PathNameExtractor = new Class(BaseNameExtractor,
  initialize: (@args) ->
    @call-super!
    @

  array: ->
    @args.join '.'

  none: ->
    throw new Error "Invalid name argument(s) for PathPipe: #{@args}"
)