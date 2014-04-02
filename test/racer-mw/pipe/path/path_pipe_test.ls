requires = require '../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

PathPipe  = requires.apipe 'path'

describe 'PathPipe' ->
  var pipe, obj

  describe 'init' ->
    context 'no args' ->
      specify 'fails - must take value for path' ->
        expect(-> new PathPipe).to.throw

    context 'arg: empty object' ->
      before ->
        obj := {}

      specify 'fails' ->
        expect(-> new PathPipe obj).to.throw

    context 'arg: object with _clazz' ->
      before ->
        obj := {_clazz: 'user'}

      specify 'fails' ->
        expect(-> new PathPipe obj).to.throw

    context 'arg: string' ->
      specify 'creates it' ->
        expect(new PathPipe 'users').to.be.an.instance-of PathPipe

      specify 'sets name to users' ->
        expect(new PathPipe('users').name).to.eq 'users'

    context 'arg: function' ->
      specify 'fails' ->
        expect(-> new PathPipe(-> 'users')).to.throw

    context 'arg: array' ->
      specify 'creates it' ->
        expect(-> new PathPipe '_page', 'admins').to.throw

      context 'long path' ->
        before ->
          pipe := new PathPipe '_page', 'admins'

        specify 'creates it' ->
          expect(pipe).to.be.an.instance-of PathPipe

        specify 'name concatenes with .' ->
          expect(pipe.name).to.eq '_page.admins'

    context 'arg: number' ->
      specify 'fails' ->
        expect(-> new PathPipe 1).to.throw Error

