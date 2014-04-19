Class  = require('jsclass/src/core').Class

requires = require '../../../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

# CollectionModelPipe       = requires.pipe!model!file 'collection_model_pipe'

# CollectionModelSetter     = requires.pipe!model!setter!named 'collection_model'

describe 'CollectionModelSetter' ->
  var pipe

  describe 'initialize' ->


  context 'instance' ->
    before ->
      # pipe := new CollectionModelPipe 'admin'
