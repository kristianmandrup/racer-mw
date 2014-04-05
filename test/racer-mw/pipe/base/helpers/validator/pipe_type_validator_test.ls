Class   = require('jsclass/src/core').Class
get     = require '../../../../requires' .get!
expect  = require('chai').expect
get.test 'test_setup'

BasePipe          = get.apipe 'base'
PipeTypeValidator = get.base-validator 'type'

describe 'PipeTypeValidator' ->
  var pipe, validator

  pipes = {}

  describe 'init' ->
    before ->
      pipe := new BasePipe 'simple'



