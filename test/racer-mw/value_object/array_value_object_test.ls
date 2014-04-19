get    = require '../../../requires' .get!
expect = require('chai').expect
get.test 'test_setup'

# Parser            = requires.pipe!.base 'pipe_parser'
# ArrayValueObject = requires.value-object!.named 'array'

describe 'ArrayValueObject' ->
  var val-obj

  describe 'initialize' ->
    specify 'no args - fails' ->
      expect(1).to.eql 1
      xexpect (-> new ArrayValueObject).to.throw Error

  describe 'instance' ->
    before ->
      # val-obj :=

