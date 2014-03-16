Class  = require('jsclass/src/core').Class

requires = require '../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

PipeValue       = requires.pipe   'value'
ValueObject     = requires.lib 'value_object'

PipeWithValue = new Class(
  include: PipeValue

  initialize: ->
    @call-super!
    @
)

Parser          = requires.pipe   'parser'

describe 'PipeValue' ->
  var pipe, obj, result, raw, parser

  context 'pipe with value' ->
    before ->
      pipe := new PipeWithValue

    describe 'set-value' ->
      before ->
        result := pipe.set-value 'x'

      specify 'result is value that was set' ->
        expect(result).to.eq 'x'

      context 'set value to x' ->
        before ->
          pipe.set-value 'x'

        specify 'value-obj is a ValueObject' ->
          expect(pipe.value-obj).to.be.an.instance-of ValueObject

        specify 'value-obj.value is x' ->
          expect(pipe.value-obj.value).to.eql 'x'

        specify 'value! is x' ->
          expect(pipe.value!).to.eql 'x'

    describe 'raw-value ' ->
      context 'model with two attributes' ->
        before ->
          obj :=
            admin:
              name: 'kris'
              email: 'kris@the.man'

          parser  := new Parser obj
          # parser.debug!

          model = parser.parse!
          raw := model.raw-value!

        specify 'gets raw value from attributes' ->
          expect(raw).to.eql obj


