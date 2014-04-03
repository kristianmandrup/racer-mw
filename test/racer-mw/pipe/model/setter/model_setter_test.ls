Class  = require('jsclass/src/core').Class

requires = require '../../../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

# ModelPipe       = requires.d.pipe   'model'

describe 'ModelSetter' ->
  var pipe

  describe 'initialize' ->


  context 'instance' ->
    before ->
      # pipe := new ModelPipe 'admin'
