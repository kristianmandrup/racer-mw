get     = require '../../../../../requires' .get!
expect  = require('chai').expect
get.test 'test_setup'

NameExtractor = get.attribute-extractor 'name'

describe 'AttributeNameExtractor' ->
  var pipe

  describe 'module' ->
    context 'initialize' ->
      specify 'no args - fails ' ->
        expect(-> new AttributePipe).to.throw
