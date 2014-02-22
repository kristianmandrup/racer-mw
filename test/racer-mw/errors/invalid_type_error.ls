requires = require '../../../requires'

requires.test 'test_setup'

expect = require('chai').expect

errors               = requires.lib 'errors'
InvalidTypeError     = errors.InvalidTypeError

describe 'InvalidTypeError' ->
  specify 'throws it' ->
    expect( -> throw new InvalidTypeError "failed" ).to.throw new InvalidTypeError

