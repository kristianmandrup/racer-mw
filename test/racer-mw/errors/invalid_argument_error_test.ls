requires = require '../../../requires'

requires.test 'test_setup'

expect = require('chai').expect

errors               = requires.lib 'errors'
InvalidArgumentError = errors.InvalidArgumentError

describe 'InvalidArgumentError' ->
  specify 'throws it' ->
    expect( -> throw new InvalidArgumentError "failed" ).to.throw new InvalidArgumentError
