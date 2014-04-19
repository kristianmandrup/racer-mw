Class   = require 'jsclass/src/core' .Class
get     = require '../../../requires' .get!
expect  = require('chai').expect
get.test 'test_setup'

ValueObject     = get.value-object 'base'

container = {
  name: 'email'
  pipe-type: 'Attribute'
}

describe 'BaseValueObject' ->
  var value-obj, result

  describe 'create' ->
    specify 'no args - fails' ->
      expect(-> new ValueObject).to.throw Error

    specify 'args: x - fails' ->
      expect(-> new ValueObject 'x').to.throw Error

    specify 'args: value: x - ok' ->
      expect(-> new ValueObject value: 'x').to.not.throw Error

    specify 'args: value: x - sets value to x' ->
      expect(new ValueObject value: 'x' .value).to.eql 'x'

  context 'empty container' ->
    before ->
      value-obj := new ValueObject value: {}

    describe 'valid' ->
      specify 'is initially true' ->
        expect(value-obj.valid).to.be.true

    describe 'validate' ->
      specify 'always true by default' ->
        expect(value-obj.validate!).to.be.true

    describe 'set' ->
      specify 'validates and sets value' ->
        expect(value-obj.set-value 'x' .value).to.eq 'x'

  context 'value x' ->
    before ->
      value-obj := new ValueObject value: 'x'

    describe 'set' ->
      specify 'validates and sets value' ->
        expect(value-obj.set-value 'x' .value).to.eq 'x'

    context 'email validation' ->
      before ->
        value-obj.validate = ->
          return false unless typeof! @value is 'String'
          @value.match(/@/) isnt null

      describe 'validate' ->
        specify 'valid: true' ->
          value-obj.set-value 'kris@gmail.com'
          expect(value-obj.validate!).to.be.true

        specify 'invalid: false' ->
          value-obj.set-value 'invalid email'
          expect(value-obj.validate!).to.be.false

      describe 'set' ->
        specify 'returns valid value set' ->
          expect(value-obj.set 'kris@gmail.com' .value).to.eql 'kris@gmail.com'

        specify 'valid: true' ->
          value-obj.set 'kris@gmail.com'
          expect(value-obj.valid).to.be.ok

        specify 'returns undefined when invalid and can NOT be set' ->
          expect(value-obj.set 'invalid email' .value).to.be.undefined

        specify 'valid: false' ->
          value-obj.set 'kris com'
          expect(value-obj.valid).to.be.false
