Class  = require('jsclass/src/core').Class

requires = require '../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

ValueObject     = requires.lib 'value_object'

container = {
  name: 'email'
  pipe-type: 'Attribute'
}

describe 'ValueObject' ->
  var value-obj, result

  context 'empty container' ->
    before ->
      value-obj := new ValueObject {}

    describe 'valid' ->
      specify 'is initially false' ->
        expect(value-obj.valid).to.be.false

    describe 'validate' ->
      specify 'always true by default' ->
        expect(value-obj.validate!).to.be.true

    describe 'set' ->
      specify 'validates and sets value' ->
        expect(value-obj.set-value 'x').to.eq 'x'

  context 'container with name and type' ->
    before ->
      value-obj := new ValueObject container

    describe 'set' ->
      specify 'validates and sets value' ->
        expect(value-obj.set-value 'x').to.eq 'x'

