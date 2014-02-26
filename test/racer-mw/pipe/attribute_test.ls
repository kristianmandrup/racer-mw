requires = require '../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

AttributePipe  = requires.pipe 'attribute'

describe 'AttributePipe' ->
  var pipe, obj

  describe 'init' ->
    context 'no args' ->
      specify 'fails - must take value for path' ->
        expect(-> new AttributePipe).to.throw

    context 'arg: empty object' ->
      before ->
        obj := {}

      specify 'creates it' ->
        expect(-> new AttributePipe obj).to.throw

    context 'arg: object with _clazz' ->
      before ->
        obj := {_clazz: 'user'}

      specify 'creates it' ->
        expect(new AttributePipe obj).to.be.an.instance-of AttributePipe

      specify 'sets name to users' ->
        expect(new AttributePipe(obj).name).to.eq 'users'

    context 'arg: string' ->
      specify 'creates it' ->
        expect(new AttributePipe 'users').to.be.an.instance-of AttributePipe

      specify 'sets name to users' ->
        expect(new AttributePipe('users').name).to.eq 'users'

    context 'arg: function' ->
      specify 'creates it' ->
        expect(-> new AttributePipe (-> 'users')).to.not.throw

      specify 'creates it' ->
        expect(new AttributePipe 'users').to.be.an.instance-of AttributePipe

    context 'arg: array' ->
      specify 'creates it' ->
        expect(-> new AttributePipe '_page', 'admins').to.not.throw

      specify 'creates it' ->
        expect(new AttributePipe '_page', 'admins').to.be.an.instance-of AttributePipe

    context 'arg: number' ->
      specify 'creates it only if child of collection - fails here' ->
        expect(-> new AttributePipe 1).to.throw Error

  context 'Pipe: parentless users' ->
    before ->
      pipe := new AttributePipe 'users'

    describe 'children' ->
      specify 'none' ->
        expect(pipe.children).to.be.empty

    describe 'parent' ->
      specify 'is void' ->
        expect(pipe.parent).to.be.undefined
