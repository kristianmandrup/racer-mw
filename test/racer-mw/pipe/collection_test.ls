requires = require '../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

CollectionPipe  = requires.pipe 'collection'

describe 'CollectionPipe' ->
  var pipe

  describe 'init' ->
    context 'no args' ->
      specify 'fails - must take value for path' ->
        expect(-> new CollectionPipe).to.throw

    context 'arg: object' ->
      specify 'creates it' ->
        expect(-> new CollectionPipe {}).to.not.throw

      specify 'creates it' ->
        expect(new CollectionPipe {}).to.be.an.instance-of CollectionPipe


    context 'arg: string' ->
      specify 'creates it' ->
        expect(-> new CollectionPipe 'users').to.not.throw

    context 'arg: function' ->
      specify 'creates it' ->
        expect(-> new CollectionPipe (-> 'users')).to.not.throw

      specify 'creates it' ->
        expect(new CollectionPipe 'users').to.be.an.instance-of CollectionPipe

    context 'arg: array' ->
      specify 'creates it' ->
        expect(-> new CollectionPipe '_page', 'admins').to.not.throw

      specify 'creates it' ->
        expect(new CollectionPipe '_page', 'admins').to.be.an.instance-of CollectionPipe

    context 'arg: number' ->
      specify 'creates it only if child of collection - fails here' ->
        expect(-> new CollectionPipe 1).to.throw Error

  context 'Pipe: parentless users' ->
    before ->
      pipe := new CollectionPipe 'users'

    describe 'children' ->
      specify 'none' ->
        expect(pipe.children).to.be.empty

    describe 'parent' ->
      specify 'is void' ->
        expect(pipe.parent).to.be.undefined
