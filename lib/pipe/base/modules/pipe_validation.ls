Module    = require('jsclass/src/core').Module
get       = require '../../../../requires' .get!

PipeValidator  = get.base-helper \validator

PipeValidation = new Module(
  is-pipe: (pipe) ->
    new PipeValidator(pipe).validate!
    true
)

module.exports = PipeValidation
