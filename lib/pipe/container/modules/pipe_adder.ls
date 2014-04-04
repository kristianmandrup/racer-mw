Module    = require('jsclass/src/core').Module
get       = require '../../../../requires' .get!

attach-helpers    = get.pipe-helper 'pipe_attacher'

PipeAttachHelper  = attach-helpers.attacher
PipeDetachHelper  = attach-helpers.detacher

PipeAdder = new Module(
  # when attached, a pipe should update its cached full-name
  add: (...args) ->
    @adder!add args

  # returns a freshly built pipe
  build: (...args) ->
    @adder!build args

  adder: ->
    new PipeAddHelper @
)

module.exports = PipeAdder