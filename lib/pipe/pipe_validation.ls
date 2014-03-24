Module       = require('jsclass/src/core').Module

requires = require '../../requires'

PipeValidator     = requires.pipe 'validator/pipe_validator'

PipeValidation = new Module(
  is-pipe: (pipe) ->
    console.log 'pipe', pipe
    new PipeValidator(pipe).validate!
    true
)

module.exports = PipeValidation
