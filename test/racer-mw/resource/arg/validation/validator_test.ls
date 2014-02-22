requires = require '../../../../../requires'

requires.test 'test_setup'

Validator       = requires.resource 'arg/validation/validator'
ErrorHandler    = requires.resource 'arg/validation/error_handler'
ArgStore        = requires.resource 'arg/store'

expect = require('chai').expect

errors        = requires.lib 'errors'

describe 'Validator' ->
  var validator
  validators = {}

  describe 'init' ->
    context 'no args' ->
      specify 'creates it' ->
        expect(-> new Validator).to.throw

    context 'valid args' ->
      before ->
        validator     := new Validator 'get', id: 0
      specify 'has command Object' ->
        expect(new Validator.command).to.be.an.instance-of Object

      specify 'has arg keys' ->
        expect(new Validator.arg-keys).to.not.be.empty

  context 'validator instance' ->
    before ->
      validator     := new Validator

    xdescribe 'error' ->
      specify 'is an ErrorHandler' ->
        expect(validator.error).to.be.an.instance-of ErrorHandler

    xdescribe 'create-error-handler' ->
      specify 'creates an ErrorHandler' ->
        expect(validator.create-error-handler!).to.be.an.instance-of ErrorHandler

    xdescribe 'arg-store' ->
      specify 'creates an ArgStore' ->
        expect(validator.arg-store!).to.be.an.instance-of ArgStore
