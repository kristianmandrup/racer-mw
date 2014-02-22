requires = require '../../../../../requires'

requires.test 'test_setup'

Validator       = requires.resource 'arg/validation/validator'
TypeValidator   = requires.resource 'arg/validation/type_validator'
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
        expect(validator.command).to.be.an.instance-of Object

      specify 'has arg keys' ->
        expect(validator.arg-keys).to.not.be.empty

  context 'validator instance' ->
    before ->
      validator     := new Validator 'add', id: 0

    describe 'error' ->
      specify 'is an ErrorHandler' ->
        expect(validator.error!).to.be.an.instance-of ErrorHandler

    describe 'create-error-handler' ->
      specify 'creates an ErrorHandler' ->
        expect(validator.create-error-handler!).to.be.an.instance-of ErrorHandler

    describe 'arg-store' ->
      specify 'creates an ArgStore' ->
        expect(validator.arg-store!).to.be.an.instance-of ArgStore

    describe 'detect-invalid' ->
      specify 'detects invalid id for add' ->
        expect(validator.detect-invalid!).to.equal false

    describe 'validate-required-key' ->
      specify 'detects required object not present' ->
        expect(-> validator.validate-required-key 'object').to.throw # new errors.RequiredArgumentError

    describe 'validate-required' ->
      specify 'detects not required object' ->
        expect(-> validator.validate-required!).to.throw # new errors.RequiredArgumentError

    describe 'get-type-validator' ->
      specify 'detects invalid id for add' ->
        expect(validator.get-type-validator!).to.be.an.instance-of TypeValidator

    describe 'validate' ->
      specify 'detects invalid id for add' ->
        expect(-> validator.validate).to.throw

