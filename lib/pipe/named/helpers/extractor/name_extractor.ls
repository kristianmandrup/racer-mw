Class   = require('jsclass/src/core').Class
get     = require '../../../../../requires' .get!
_       = require 'prelude-ls'
lo      = require 'lodash'
util    = require 'util'
require 'sugar'

BaseExtractor = get.base-helper 'base_extractor'

NameExtractor = new Class(BaseExtractor,
  initialize: (@pipe) ->
    @call-super @pipe.args.0
    @

  extract-and-set: ->
    @valid-args! and @pipe.set-name @extract!

  valid-args: ->
    @has-args! or throw new Error "Can't extract Pipe name without arguments, #{util.inspect @obj}"

  has-args: ->
    not lo.is-empty @obj

  string: ->
    @obj

  object: ->
    @first-key!

  first-key: ->
    @keys!.first!

  keys: ->
    _.keys @obj

  # call again with normalized args
  hash-extractor: ->
    new NameExtractor @hash!
)

module.exports = NameExtractor