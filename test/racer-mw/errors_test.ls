requires = require '../../requires'

requires.test 'test_setup'

expect = require('chai').expect

errors                    = requires.lib 'errors'
ArgumentError             = errors.ArgumentError
RequiredArgumentError     = errors.RequiredArgumentError

describe 'errors' ->
  specify 'throws ArgumentError' ->
    expect( -> throw new ArgumentError "failed" ).to.throw new ArgumentError

  specify 'throws RequiredArgumentError' ->
    expect( -> throw new RequiredArgumentError "failed" ).to.throw new RequiredArgumentError

