Class  = require('jsclass/src/core').Class

requires = require '../../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

AttributePipe   = requires.apipe   'attribute'

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

