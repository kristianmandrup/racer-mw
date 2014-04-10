Class       = require 'jsclass/src/core' .Class
lo          = require 'lodash'

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

module.exports = PrimitiveNameExtractor