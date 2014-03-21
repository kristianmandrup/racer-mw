requires = require '../../../../../requires'

requires.test 'test_setup'

TypeValidator = requires.resource 'arg/validation/resource_arg_type_validator'
ErrorHandler  = requires.resource 'arg/validation/resource_arg_error_handler'

expect = require('chai').expect

errors        = requires.lib 'errors'

describe 'TypeValidator' ->
  var validator, err-handler
  validators = {}

  before ->
    validator     := new TypeValidator
    err-handler   := new ErrorHandler 'get', {x:1}, {index: 0}

  describe 'valid-types-for' ->
    specify 'collection => string' ->
      expect(validator.valid-types-for 'collection').to.include 'string'

    specify 'index => number' ->
      expect(validator.valid-types-for 'index').to.include 'number'

  describe 'type-map' ->
    specify 'is an Object' ->
      expect(validator.type-map!).to.not.be.empty

    specify 'collection => string' ->
      expect(validator.type-map!['collection']).to.equal 'string'

  describe 'is-valid' ->
    specify 'string is valid for collection' ->
      expect(validator.is-valid 'collection', 'users').to.be.ok

    specify 'collection => string' ->
      expect(validator.is-valid 'collection', 4).to.not.be.ok

  describe 'validate-type' ->
    specify 'index: 0 is valid' ->
      validators.index0 = new TypeValidator err-handler, index: 0
      expect(validators.index0.validate-type 'index', 0).to.be.true

    specify 'collection: 0 is invalid' ->
      validators.col0 = new TypeValidator err-handler,collection: 0
      expect(-> validators.col0.validate-type 'index', 'x').to.throw new errors.InvalidArgumentError


  describe 'validate' ->
    specify 'index: 0 is valid' ->
      validators.index0 = new TypeValidator err-handler, index: 0
      expect(validators.index0.validate!).to.be.true

    specify 'collection: 0 is invalid' ->
      validators.col0 = new TypeValidator err-handler,collection: 0
      expect(-> validators.col0.validate!).to.throw new errors.InvalidArgumentError
