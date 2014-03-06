requires = require '../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

ColModelPipe    = requires.pipe     'col_model'
ResourceModel   = requires.resource 'model'

describe 'ColModelPipe' ->
  var pipe, obj

  pipes = {}

  describe 'init' ->
    context 'no args' ->
      specify 'fails - must take value for path' ->
        expect(-> new ColModelPipe).to.throw

    context 'arg: empty object' ->
      before ->
        obj := {}

      specify 'fails - obj must have a _clazz' ->
        expect(-> new ColModelPipe obj).to.throw

    context 'arg: object with _clazz' ->
      before ->
        obj := {_clazz: 'user'}

      specify 'fails' ->
        expect(-> new ColModelPipe obj).to.not.throw

      specify 'sets name to user' ->
        expect(new ColModelPipe(obj).name).to.eq 'user'

      specify 'id throws since not part of a collection' ->
        expect(-> new ColModelPipe(obj).id!).to.throw

    context 'arg: attribute: {_clazz: name }' ->
      before ->
        obj := {_clazz: 'user'}

      specify 'fails' ->
        expect(-> new ColModelPipe admin: obj).to.not.throw

      specify 'sets name to admin' ->
        expect(new ColModelPipe(admin: obj).name).to.eq 'admin'
