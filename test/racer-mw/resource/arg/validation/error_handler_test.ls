requires = require '../../../../../requires'

requires.test 'test_setup'

ErrorHandler = requires.resource 'arg/validation/error_handler'

expect = require('chai').expect

errors        = requires.lib 'errors'
ArgumentError = errors.ArgumentError

describe 'ErrorHandler' ->
  describe 'init' ->
    handlers = {}

    specify 'no args throws' ->
      expect( -> new ErrorHandler).to.throw new ArgumentError

    specify '1 arg throws' ->
      expect( -> new ErrorHandler).to.throw new ArgumentError

    specify 'invalid 3 args throws' ->
      expect(-> new ErrorHandler 3, {x: 1}, {a: 2}).to.throw new ArgumentError

    specify 'valid 3 args does not throw' ->
      expect( -> new ErrorHandler 'x', {x: 1}, {a: 2}).to.not.throw