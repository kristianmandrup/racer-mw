requires = require '../../../../../requires'

requires.test 'test_setup'

ErrorHandler = requires.resource 'arg/validation/error_handler'

expect = require('chai').expect

errors        = requires.lib 'errors'

describe 'ErrorHandler' ->
  describe 'init' ->
    handlers = {}

    specify 'no args throws' ->
      expect( -> new ErrorHandler).to.throw new errors.InvalidArgumentError

    specify '1 arg throws' ->
      expect( -> new ErrorHandler).to.throw new errors.InvalidArgumentError

    specify 'invalid 3 args throws' ->
      expect(-> new ErrorHandler 3, {x: 1}, {a: 2}).to.throw new errors.InvalidArgumentError

    specify 'valid 3 args does not throw' ->
      expect( -> new ErrorHandler 'x', {x: 1}, {a: 2}).to.not.throw

    describe 'handlers' ->
      before ->
        handlers.arg-x = new ErrorHandler 'get', {command-name: 1}, x: 27

      describe 'invalid-name' ->
        specify 'prints to console' ->
          expect(-> handlers.arg-x.invalid-name).to.not.throw

      describe 'invalid-type' ->
        specify 'throws InvalidTypeError' ->
          expect(-> handlers.arg-x.invalid-type 'index', 'none', ['number']).to.throw new errors.InvalidTypeError

      describe 'required' ->
        specify 'throws ArgumentError' ->
          expect(-> handlers.arg-x.required 'index').to.throw new errors.ArgumentError