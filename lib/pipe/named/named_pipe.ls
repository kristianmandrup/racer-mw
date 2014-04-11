Module      = require 'jsclass/src/core' .Module
get         = require '../../../requires' .get!
lo          = require 'lodash'

PipeBasic                = get.base-module 'basic'
PrimitiveNameExtractor   = get.named-extractor 'primitive_name'

NamedPipe = new Module(
  include:
    * PipeBasic # Setter and such
    ...

  initialize: (...@args) ->
    @name-extractor!.extract-and-set!
    @call-super! if @call-super
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