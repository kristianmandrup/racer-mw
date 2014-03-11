Class  = require('jsclass/src/core').Class

requires = require '../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

PipeValue       = requires.pipe   'value'
ValueObject     = requires.lib 'value_object'

PipeWithValue = new Class(
  include: PipeValue

  initialize: ->
    @
)

describe 'PipeValue' ->
  var pipe, result

  context 'pipe with value' ->
    before ->
      pipe := new PipeWithValue

    describe 'get-value' ->
      specify 'returns void' ->
        expect(pipe.get-value!).to.be.undefined

    describe 'set-value' ->
      before ->
        result := pipe.set-value 'x'

      specify 'set value to ValueObject' ->
        expect(result).to.eq pipe

      specify 'set value to ValueObject' ->
        expect(pipe.value).to.be.an.instance-of ValueObject

      # TODO: should be value-obj.value
      specify 'set value to ValueObject' ->
        expect(pipe.value-obj.value).to.eql 'x'

      specify 'set value to ValueObject' ->
        expect(pipe.value!).to.eql 'x'
