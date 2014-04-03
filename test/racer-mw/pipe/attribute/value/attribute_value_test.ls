Class  = require('jsclass/src/core').Class
get    = require '../../../../../requires' .get!
expect = require('chai').expect
get.test 'test_setup'

AttributePipe  = get.apipe 'attribute'

describe 'PipeValue' ->
  var pipe, obj, result, raw, raw-contained, parser, users

  context 'AttributePipe' ->
    before ->
      pipe := new AttributePipe 'name'

    describe 'set-value' ->
      before ->
        result := pipe.set-value 'mikey'

      specify 'result is value that was set' ->
        expect(result).to.equal 'mikey'

