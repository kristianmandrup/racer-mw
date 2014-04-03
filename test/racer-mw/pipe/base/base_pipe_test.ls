requires = require '../../../../requires'

requires.test 'test_setup'

pipe = ->
  requires.pipe!.named

BaseBasePipe          = pipe 'base'
ModelBasePipe         = pipe 'model'
CollectionBasePipe    = pipe 'collection'

ParentValidator   = requires.pipe!validator!named  'parent'

expect      = require('chai').expect

describe 'BaseBasePipe' ->
  var pipe, obj, parent-pipe, model-pipe

  describe 'init' ->
    context 'no args' ->
      specify 'fails - must take value for path' ->
        expect(-> new BaseBasePipe).to.throw

    context 'arg: object' ->
      specify 'creates it' ->
        expect(-> new BaseBasePipe {}).to.not.throw

      specify 'creates it' ->
        expect(new BaseBasePipe {}).to.be.an.instance-of BaseBasePipe

      describe 'pipe' ->
        before ->
          pipe := new BaseBasePipe {}

        specify 'has-resource is true by default' ->
          expect(pipe.has-resource).to.be.true

    context 'arg: string' ->
      specify 'creates it' ->
        expect(-> new BaseBasePipe 'users').to.not.throw

    context 'arg: function' ->
      specify 'creates it' ->
        expect(-> new BasePipe (-> 'users')).to.not.throw

      specify 'creates it' ->
        expect(new BasePipe 'users').to.be.an.instance-of BasePipe

    context 'arg: array' ->
      specify 'creates it' ->
        expect(-> new BasePipe '_page', 'admins').to.not.throw

      specify 'creates it' ->
        expect(new BasePipe '_page', 'admins').to.be.an.instance-of BasePipe

    context 'arg: number' ->
      specify 'always fails' ->
        expect(-> new BasePipe 1).to.throw Error

  context 'BasePipe: parentless users' ->
    before ->
      pipe        := new BasePipe 'users'
      parent-pipe := new BasePipe 'parent'

    describe 'children' ->
      specify 'none' ->
        expect(pipe.children).to.be.empty

    describe 'parent' ->
      specify 'is void' ->
        expect(pipe.parent).to.be.undefined

    describe 'parent-validator' ->
      specify 'is a ParentValidator' ->
        expect(pipe.parent-validator parent-pipe).to.be.an.instance-of ParentValidator
