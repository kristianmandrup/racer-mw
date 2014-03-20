requires = require '../../../requires'

requires.test 'test_setup'

Pipe              = requires.apipe 'base'
ModelPipe         = requires.apipe 'model'
CollectionPipe    = requires.apipe 'collection'

ParentValidator   = requires.pipe  'validator/parent_validator'

expect      = require('chai').expect

describe 'Pipe' ->
  var pipe, obj, parent-pipe, model-pipe

  describe 'init' ->
    context 'no args' ->
      specify 'fails - must take value for path' ->
        expect(-> new Pipe).to.throw

    context 'arg: object' ->
      specify 'creates it' ->
        expect(-> new Pipe {}).to.not.throw

      specify 'creates it' ->
        expect(new Pipe {}).to.be.an.instance-of Pipe

      describe 'pipe' ->
        before ->
          pipe := new Pipe {}

        specify 'has-resource is true by default' ->
          expect(pipe.has-resource).to.be.true

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
      specify 'always fails' ->
        expect(-> new Pipe 1).to.throw Error

  context 'Pipe: parentless users' ->
    before ->
      pipe        := new Pipe 'users'
      parent-pipe := new Pipe 'parent'

    describe 'children' ->
      specify 'none' ->
        expect(pipe.children).to.be.empty

    describe 'parent' ->
      specify 'is void' ->
        expect(pipe.parent).to.be.undefined

    describe 'parent-validator' ->
      specify 'is a ParentValidator' ->
        expect(pipe.parent-validator parent-pipe).to.be.an.instance-of ParentValidator
