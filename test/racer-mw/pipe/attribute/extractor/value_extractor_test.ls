get     = require '../../../../../requires' .get!
expect  = require('chai').expect
get.test 'test_setup'

ValueExtractor = get.attribute-extractor 'value'

describe 'AttributeValueExtractor' ->
  var pipe

  describe 'module' ->
    context 'initialize' ->
      specify 'no args - fails ' ->
        expect(-> new AttributePipe).to.throw
