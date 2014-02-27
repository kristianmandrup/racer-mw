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

    context 'arg: attribute: {_clazz: name }' ->
      before ->
        obj := {_clazz: 'user'}

      specify 'fails' ->
        expect(-> new ModelPipe admin: obj).to.not.throw

      specify 'sets name to admin' ->
        expect(new ModelPipe(admin: obj).name).to.eq 'admin'

    context 'arg: string' ->
      specify 'fails' ->
        expect(-> new ModelPipe 'users').to.throw

    context 'arg: function' ->
      specify 'fails' ->
        expect(-> new ModelPipe (-> 'users')).to.throw

    context 'arg: array' ->
      specify 'fails' ->
        expect(-> new AttributePipe '_page', 'admins').to.throw

    context 'arg: number' ->
      specify 'fails' ->
        expect(-> new AttributePipe 1).to.throw Error

