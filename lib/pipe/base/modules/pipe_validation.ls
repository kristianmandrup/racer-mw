Module       = require('jsclass/src/core').Module

requires  = require '../../../../requires'

validator = ->
  requires.pipe!.validator!.named

PipeValidator     = validator 'pipe'

PipeValidation = new Module(
  is-pipe: (pipe) ->
    new PipeValidator(pipe).validate!
    true
)

module.exports = PipeValidation
