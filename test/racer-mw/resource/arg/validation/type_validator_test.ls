requires = require '../../../../../requires'

requires.test 'test_setup'

TypeValidator = requires.resource 'arg/validation/type_validator'

expect = require('chai').expect

errors        = requires.lib 'errors'

describe 'TypeValidator' ->
  var validator
  validators = {}

  describe 'valid-types-for' ->
    context 'index: 0' ->
      before ->
        validator := new TypeValidator

      specify 'collection => string' ->
        expect(validator.valid-types-for 'collection').to.include 'string'

      specify 'index => number' ->
        expect(validator.valid-types-for 'index').to.include 'number'

  xdescribe 'validate' ->
    before ->
      validators.index0 = new TypeValidator index: 0

    specify 'validates' ->
      expect(validators.index0.validate).to.throw new errors.InvalidArgumentError
