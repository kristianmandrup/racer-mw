Class         = require 'jsclass/src/core' .Class
get           = require '../../../requires' .get!
expect        = require('chai').expect
get.test 'test_setup'

ValueObject   = get.value-object 'object'

describe 'ObjectValueObject' ->
  var value-obj, result

  describe 'create' ->
    specify 'no args - fails' ->
      expect(-> new ValueObject).to.throw Error

    specify 'args: x - fails' ->
      expect(-> new ValueObject 'x').to.throw Error

    specify 'args: value: x - not an obj' ->
      expect(new ValueObject value: 'x' .value).to.be.undefined

    specify 'args: value: {} - sets value to x' ->
      expect(new ValueObject(value: {}).value).to.eql {}

  context 'empty value obj' ->
    before ->
      value-obj := new ValueObject value: {}

    describe 'valid' ->
      specify 'is true' ->
        expect(value-obj.valid).to.be.true

    describe 'validate' ->
      specify 'always true by default' ->
        expect(value-obj.validate!).to.be.false

    describe 'set' ->
      specify 'validates and sets value' ->
        expect(value-obj.set-value x: 2 .value).to.eql x: 2

  context 'value x: 2' ->
    before ->
      value-obj := new ValueObject value: {x: 2}

    describe 'set' ->
      specify 'validates and sets value' ->
        expect(value-obj.set-value y :3 .value).to.eql y : 3

    context 'validation x is 7' ->
      before ->
        value-obj.validate = (value) ->
          return false unless value and value.x is 7
          true

      describe 'validate' ->
        specify 'x: 7 is true' ->
          expect(value-obj.validate x : 7).to.be.true

        specify 'x: 6 is false' ->
          expect(value-obj.validate x : 6).to.be.false

      describe 'set' ->
        specify 'returns valid value set' ->
          expect(value-obj.set x: 7 .value).to.eql x : 7

        specify 'valid: true' ->
          value-obj.set x: 7
          expect(value-obj.valid).to.be.ok

        specify 'valid: false' ->
          value-obj.set x: 6
          expect(value-obj.valid).to.be.false

        specify 'value remains old value is new value is invalid' ->
          expect(value-obj.set x: 6 .value).to.eql x: 7

