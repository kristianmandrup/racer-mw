Module      = require('jsclass/src/core').Module
Class       = require('jsclass/src/core').Class
get         = require '../../../requires' .get!
lo          = require 'lodash'

PipeBasic   = get.base-module 'basic'

PrimitiveNameExtractor = new Class(
  initialize: (@name) ->

  extract: ->
    @name
)

NamedPipe = new Module(
  include:
    * PipeBasic # Setter and such
    ...

  initialize: (...@args) ->
    @call-super! if @call-super
    @extract-name!
    @

  extract-name: ->
    if @no-args!
      throw new Error "Can't extract Pipe name without arguments, #{@args}"
    @set-name @name-extractor!.extract!

  no-args: ->
    lo.is-empty @args

  # override!
  name-extractor: ->
    new PrimitiveNameExtractor(@args.1)

  set-name: (name) ->
    @name = name
    @call-super! if @call-super
    @
)

module.exports = NamedPipe