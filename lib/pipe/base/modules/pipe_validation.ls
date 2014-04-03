Module    = require('jsclass/src/core').Module
get       = require '../../../../requires' .get!

PipeValidator     = get.pipe-validator \pipe

PipeValidation = new Module(
  is-pipe: (pipe) ->
    new PipeValidator(pipe).validate!
    true
)

module.exports = PipeValidation
