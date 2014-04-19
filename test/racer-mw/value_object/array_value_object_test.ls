Class   = require 'jsclass/src/core' .Class
get     = require '../../../requires' .get!
expect  = require('chai').expect
get.test 'test_setup'

ValueObject     = get.value-object 'array'

describe 'ArrayValueObject' ->
  var value-obj

  describe 'create' ->
    specify 'no args - fails' ->
      expect(-> new ValueObject).to.throw Error

    specify 'args: x - fails' ->
      expect(-> new ValueObject 'x').to.throw Error

    specify 'args: value: x - not an obj' ->
      expect(new ValueObject value: 'x' .value).to.be.undefined

    specify 'args: value: [] - sets value to []' ->
      expect(new ValueObject(value: []).value).to.eql []

  context 'empty value obj' ->
    before ->
      value-obj := new ValueObject value: []

    describe 'valid' ->
      specify 'is true' ->
        expect(value-obj.valid).to.be.true

    describe 'validate' ->
      specify 'always true by default' ->
        expect(value-obj.validate!).to.be.true

