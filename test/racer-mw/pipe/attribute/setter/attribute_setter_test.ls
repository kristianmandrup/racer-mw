get     = require '../../../../../requires' .get!
expect  = require('chai').expect
get.test 'test_setup'

AttributePipe  = get.apipe 'attribute'

describe 'AttributeSetter' ->
  var pipe

  describe 'module' ->
    context 'initialize' ->
      specify 'no args - fails ' ->
        expect(-> new AttributePipe).to.throw
