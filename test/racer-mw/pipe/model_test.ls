requires = require '../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

ModelPipe  = requires.pipe 'model'

describe 'ModelPipe' ->
  var pipe, obj

  describe 'init' ->
    context 'no args' ->
      specify 'fails - must take value for path' ->
        expect(-> new ModelPipe).to.throw

    context 'arg: empty object' ->
      before ->
        obj := {}

      specify 'fails - obj must have a _clazz' ->
        expect(-> new ModelPipe obj).to.throw

    context 'arg: object with _clazz' ->
      before ->
        obj := {_clazz: 'user'}

      specify 'fails' ->
        expect(-> new ModelPipe obj).to.not.throw

      specify 'sets name to user' ->
        expect(new ModelPipe(obj).name).to.eq 'user'

      specify 'id undefined until part of collection' ->
        expect(new ModelPipe(obj).id!).to.be.undefined
