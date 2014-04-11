Class   = require 'jsclass/src/core' .Class
get     = require '../../../../../requires' .get!
lo      = require 'lodash'

PipeValidation = get.base-module 'validation'
util = require 'util'

PrimitiveNameExtractor = new Class(
  include: PipeValidation

  initialize: (@pipe) ->
    @is-pipe!
    @args = @pipe.args.flatten!
    @

  extract: ->
    @args.0

  extract-and-set: ->
    @valid-args! and @pipe.set-name @extract!

  valid-args: ->
    @has-args! and @valid-arg-type! or throw new Error "Can't extract Pipe name without arguments, #{util.inspect @args} #{@args.0} - #{@valid-arg-type!}"

  valid-arg-type: ->
    typeof! @args.0 is 'String'

  has-args: ->
    not lo.is-empty @args
)

module.exports = PrimitiveNameExtractor