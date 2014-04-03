get     = require '../../../../../requires' .get!
expect  = require('chai').expect
get.test 'test_setup'

PathPipe          = get.apipe 'path'
AttributePipe     = get.apipe 'attribute'
AttributeAdder    = get.attribute 'builder/attribute_adder'

describe 'AttributeAdder' ->
  var pipe, obj

  describe 'init' ->
    context 'no args' ->
      specify 'fails - must take an object that can attach' ->
        expect(-> new AttributeAdder).to.throw
