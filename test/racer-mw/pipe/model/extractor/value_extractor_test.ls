Class  = require('jsclass/src/core').Class

requires = require '../../../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

# AttributeModelPipe       = requires.pipe!model!file 'attribute_model_pipe'

# ModelValueExtractor      = requires.pipe!model!extractor!named 'model'

describe 'ModelValueExtractor' ->
  var pipe

  describe 'initialize' ->


  context 'instance' ->
    before ->
      # pipe := new AttributeModelPipe 'admin'
