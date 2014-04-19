Class   = require 'jsclass/src/core' .Class
get     = require '../../../requires' .get!
expect  = require('chai').expect
get.test 'test_setup'

ValueObject     = get.value-object 'primitive'

describe 'PrimitiveValueObject' ->
  var value-obj, result

  describe 'create' ->
    specify 'no args - fails' ->
      expect(-> new ValueObject).to.throw Error

    specify 'args: x - fails' ->
      expect(-> new ValueObject 'x').to.throw Error

    specify 'args: value: x - sets value to x' ->
      expect(new ValueObject value: 'x' .value).to.eql 'x'

    specify 'args: value: {} - void since not a primitive' ->
      expect(new ValueObject(value: {}).value).to.be.undefined

  context 'empty value obj' ->
    before ->
      value-obj := new ValueObject value: 'x'

    describe 'valid' ->
      specify 'is true' ->
        expect(value-obj.valid).to.be.true

    describe 'validate' ->
      specify 'always false by default' ->
        expect(value-obj.validate!).to.be.false

    describe 'set value to 2' ->
      specify 'is valid' ->
        expect(value-obj.set-value 2 .valid).to.be.true

      specify 'sets value' ->
        expect(value-obj.set-value 2 .value).to.eql 2

  context 'value x: 2' ->
    before ->
      value-obj := new ValueObject value: 5

    describe 'set' ->
      specify 'validates and sets value' ->
        expect(value-obj.set-value 7 .value).to.eql 7

    context 'validation: is 7' ->
      before ->
        value-obj.validate = (value) ->
          return false unless value and value is 7
          true

      describe 'validate' ->
        specify '7 is valid' ->
          expect(value-obj.validate 7).to.be.true

        specify '6 is invalid' ->
          expect(value-obj.validate 6).to.be.false

      describe 'set' ->
        specify 'returns valid value set' ->
          expect(value-obj.set 7 .value).to.eql 7

        specify 'valid: true' ->
          value-obj.set 7
          expect(value-obj.valid).to.be.ok

        specify 'valid: false' ->
          value-obj.set 6
          expect(value-obj.valid).to.be.false

        specify 'value remains old value is new value is invalid' ->
          expect(value-obj.set 6 .value).to.eql 7
