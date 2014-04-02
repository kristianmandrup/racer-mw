requires  = require '../../../requires'

expect = require('chai').expect

requires.test 'test_setup'

console.log requires.pipe!base!file 'pipe_parser'

# Parser            = requires.pipe!.base 'pipe_parser'

# ArrayValueObject = requires.value-object!.named 'array'

# console.log ArrayValueObject

describe 'ArrayValueObject' ->
  var val-obj

  describe 'initialize' ->
    specify 'no args - fails' ->
      expect(1).to.eql 1
      xexpect (-> new ArrayValueObject).to.throw Error

  describe 'instance' ->
    before ->
      # val-obj :=

