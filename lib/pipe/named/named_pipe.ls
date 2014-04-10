Module      = require 'jsclass/src/core' .Module
Class       = require 'jsclass/src/core' .Class
get         = require '../../../requires' .get!
lo          = require 'lodash'

PipeBasic   = get.base-module 'basic'

PrimitiveNameExtractor = new Class(
  initialize: (@pipe) ->
    @args = @pipe.args
    @

  extract: ->
    @name

  extract-and-set: ->
    @valid-args! and @pipe.set-name @extract!

  valid-args: ->
    @has-args! or throw new Error "Can't extract Pipe name without arguments, #{@args}"

  has-args: ->
    not lo.is-empty @args
)

NamedPipe = new Module(
  include:
    * PipeBasic # Setter and such
    ...

  initialize: (...@args) ->
    @call-super! if @call-super
    @name-extractor!.extract-and-set!
    @

  # override!
  name-extractor: ->
    new PrimitiveNameExtractor @

  set-name: (name) ->
    @name = name
    @call-super! if @call-super
    @
)

module.exports = NamedPipe