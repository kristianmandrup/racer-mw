Module    = require('jsclass/src/core').Module
get       = require '../../../../requires' .get!
_         = require 'prelude-ls'
lo        = require 'lodash'
util      = require 'util'
require 'sugar'

ParentValidator   = get.pipe-validator 'parent'

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