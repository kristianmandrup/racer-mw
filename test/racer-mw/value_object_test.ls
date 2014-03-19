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
      specify 'is initially true' ->
        expect(value-obj.valid).to.be.true

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

    context 'validation based on container' ->
      before ->
        value-obj.validate = (value) ->
          value.match(/@/) isnt null

      describe 'validate' ->
        specify 'valid: true' ->
          expect(value-obj.validate 'kris@gmail.com').to.be.true

        specify 'invalid: false' ->
          expect(value-obj.validate 'invalid email').to.be.false

      describe 'set' ->
        specify 'returns valid value set' ->
          expect(value-obj.set 'kris@gmail.com').to.eql 'kris@gmail.com'

        specify 'valid: true' ->
          value-obj.set 'kris@gmail.com'
          expect(value-obj.valid).to.be.ok

        specify 'returns undefined when invalid and can NOT be set' ->
          expect(value-obj.set 'invalid email').to.be.undefined

        specify 'valid: false' ->
          value-obj.set 'kris com'
          expect(value-obj.valid).to.be.false