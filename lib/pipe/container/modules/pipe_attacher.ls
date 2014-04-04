Module    = require('jsclass/src/core').Module
get       = require '../../../../requires' .get!

attach-helpers    = get.pipe-helper 'pipe_attacher'

PipeAttachHelper  = attach-helpers.attacher
PipeDetachHelper  = attach-helpers.detacher

PipeAttacher = new Module(
  # when attached, a pipe should update its cached full-name
  attach: (pipe) ->
    new PipeAttachHelper(@).attach pipe
    @

  detach: ->
    new PipeDetachHelper(@).attach pipe
    @
)

module.exports = PipeAttacher