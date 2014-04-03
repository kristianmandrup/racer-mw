Class       = require('jsclass/src/core').Class

requires = require '../../../../requires'

requires.test 'test_setup'

pipe = ->
  requires.pipe!.named

validator = ->
  requires.pipe!.validator!.named

BasePipe          = pipe 'base'
PipeTypeValidator = validator 'pipe_type'

expect      = require('chai').expect
