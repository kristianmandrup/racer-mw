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

ModelPipe       = requires.apipe   'model'
CollectionPipe  = requires.apipe   'collection'
AttributePipe   = requires.apipe   'attribute'
PathPipe        = requires.apipe   'path'

describe 'PipeValue' ->
  var pipe, obj, result, raw, raw-contained, parser

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
        var model
        before ->
          obj :=
            admin:
              name: 'kris'
              email: 'kris@the.man'

          parser  := new Parser obj
          # parser.debug!

          model         := parser.parse!
          raw-contained := model.raw-value true
          raw           := model.raw-value!

        specify 'model is a ModelPipe' ->
          expect(model).to.be.an.instance-of ModelPipe

        specify 'name is an AttributePipe' ->
          expect(model.child 'name').to.be.an.instance-of AttributePipe

        specify 'gets raw contained value from attributes' ->
          expect(raw-contained ).to.eql obj

        specify 'gets raw value from attributes' ->
          expect(raw).to.eql {name: 'kris', email: 'kris@the.man'}

        describe 'on child update' ->
          specify 'parent sets new computed value' ->
            child = model.child('name')

            model.on-child-update child, 'emma'
            expect(model.value!).to.eql {name: 'emma', email: 'kris@the.man'}

        specify 'notify parent on child value change' ->
          model.child('name').set-value 'emma'
          expect(model.value!).to.eql {name: 'emma', email: 'kris@the.man'}
