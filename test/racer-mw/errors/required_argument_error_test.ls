requires = require '../../../requires'

requires.test 'test_setup'

expect = require('chai').expect

errors                    = requires.lib 'errors'
RequiredArgumentError     = errors.RequiredArgumentError

describe 'RequiredArgumentError' ->
  specify 'throws it' ->
    expect( -> throw new RequiredArgumentError "failed" ).to.throw new RequiredArgumentError

