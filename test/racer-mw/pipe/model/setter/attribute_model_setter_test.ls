Class   = require('jsclass/src/core').Class
get     = require '../../../../../requires' .get!
expect  = require('chai').expect
get.test 'test_setup'

AttributeModelPipe       = get.model model 'attribute_model'
AttributeModelSetter     = get.model-setter 'attribute_model'

describe 'AttributeModelSetter' ->
  var pipe

  describe 'initialize' ->
    specify 'no args - fails' ->
      expect(-> new AttributeModelSetter).to.throw Error

  context 'instance' ->
    before ->
      # pipe := new AttributeModelPipe 'admin'
