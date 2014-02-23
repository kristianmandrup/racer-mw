requires = require '../../../requires'

requires.test 'test_setup'

requires = require '../../../requires'

Pipe        = requires.pipe 'base'

expect      = require('chai').expect

describe 'Pipe' ->
  var pipe

  describe 'init' ->
    context 'no args' ->
      specify 'fails - must take value for path' ->
        expect(-> new Pipe).to.throw

    context 'arg: object' ->
      specify 'creates it' ->
        expect(-> new Pipe {}).to.not.throw

      specify 'creates it' ->
        expect(new Pipe {}).to.be.an.instance-of Pipe


    context 'arg: string' ->
      specify 'creates it' ->
        expect(-> new Pipe 'users').to.not.throw

    context 'arg: function' ->
      specify 'creates it' ->
        expect(-> new Pipe (-> 'users')).to.not.throw

      specify 'creates it' ->
        expect(new Pipe 'users').to.be.an.instance-of Pipe

    context 'arg: array' ->
      specify 'creates it' ->
        expect(-> new Pipe '_page', 'admins').to.not.throw

      specify 'creates it' ->
        expect(new Pipe '_page', 'admins').to.be.an.instance-of Pipe

    context 'arg: number' ->
      specify 'creates it only if child of collection - fails here' ->
        expect(-> new Pipe 1).to.throw Error

  context 'Pipe: parentless users' ->
    before ->
      pipe := new Pipe 'users'

    describe 'no children' ->
      expect(pipe.children).to.be.empty

    describe 'parent is void' ->
      expect(pipe.parent).to.be.undefined
