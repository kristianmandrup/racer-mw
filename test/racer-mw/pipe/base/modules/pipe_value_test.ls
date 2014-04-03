Class  = require('jsclass/src/core').Class
get = require '../../../../../requires' .get!
get.test 'test_setup'
expect = require('chai').expect

PipeValue       = get.base-module  'value'
ValueObject     = get.value-object 'base'

PipeWithValue = new Class(
  include: PipeValue

  initialize: ->
    @call-super!
    @
)

Parser          = requires.pipe   'pipe_parser'

ModelPipe       = requires.apipe   'model'
CollectionPipe  = requires.apipe   'collection'
AttributePipe   = requires.apipe   'attribute'
PathPipe        = requires.apipe   'path'

describe 'PipeValue' ->
  var pipe, obj, result, raw, raw-contained, parser, users

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

    describe 'raw-value ' ->
      context 'collection with one model' ->
        var users
        before ->
          obj :=
            users:
              * name: 'kris'
                email: 'kris@the.man'
              ...

          parser  := new Parser obj
          # parser.debug!

          users         := parser.parse!
          raw-contained := users.raw-value true
          raw           := users.raw-value!

        specify 'model is a ModelPipe' ->
          expect(users).to.be.an.instance-of CollectionPipe

        specify 'name is an AttributePipe' ->
          expect(users.child '0').to.be.an.instance-of ModelPipe

        specify 'gets raw value from attributes' ->
          expect(raw).to.eql {0: {name: 'kris', email: 'kris@the.man'} }

        specify 'gets raw contained value from attributes' ->
          expect(raw-contained).to.eql users: {0: {name: 'kris', email: 'kris@the.man'} }

  context 'users' ->
    before ->
      obj :=
        users:
          * name: 'kris'
            email: 'kris@the.man'
          ...

      parser  := new Parser obj
      # parser.debug!

      users         := parser.parse!
      console.log obj
      console.log users.describe true

    describe 'on child update' ->
      before ->
        child = users.get 0
        users.on-child-update child, {name: 'mike', email: 'mike@the.man'}

      specify 'parent does not set new computed value' ->
        expect(users.value!).to.eql { 0: {name: 'kris', email: 'kris@the.man'} }

    describe 'set value' ->
      var res
      before ->
        console.log users.describe!
        child = users.get 0
        res := child.set-value {name: 'mike', email: 'mike@the.man'}
        console.log 'RES', res

      specify.only 'notify parent on child value change' ->
        expect(users.value!).to.eql { 0: {name: 'mike', email: 'mike@the.man'} }