Class       = require('jsclass/src/core').Class

requires = require '../../../../requires'

requires.test 'test_setup'

BasePipe          = requires.apipe 'base'
ParentValidator   = requires.pipe 'validator/parent_validator'

expect      = require('chai').expect

Pipe = new Class(BasePipe,
  initialize: ->
    @call-super!
    @post-init!
    @

  id: ->
    'pipe'
)

describe 'Pipe ParentValidator' ->
  var pipe, validator

  pipes = {}

  describe 'init' ->
    before ->
      pipe := new Pipe 'simple'

    describe 'must take an array of valid types to validate pipes against' ->
      context 'no args' ->
        specify 'fails' ->
          expect(-> new ParentValidator).to.throw

      context 'one arg' ->
        specify 'string fails' ->
          expect(-> new ParentValidator 'pipe').to.throw

        specify 'pipe ok' ->
          expect(-> new ParentValidator pipe).to.not.throw

      context 'two args' ->
        specify 'fails' ->
          expect(-> new ParentValidator pipe).to.throw

    describe 'set-valid' ->
      before ->
        validator := new ParentValidator pipe

      specify 'list of strings is ok' ->
        expect(validator.set-valid 'x', 'y').to.not.throw

      specify  'empty list is ok' ->
        expect(validator.set-valid []).to.not.throw

  describe 'ancestors' ->
    before ->
      pipes.child := new Pipe 'kid'
      pipes.pere := new Pipe 'daddy'
      pipes.grand-pere := new Pipe 'grand daddy'
      pipes.child.parent = pipes.pere
      pipes.pere.parent = pipes.grand-pere

      validator := new ParentValidator pipes.child

    specify 'grand-pere is in parent ancestor' ->
      expect(pipes.grand-pere in validator.ancestors!).to.be.true

    specify 'pere is-ancestor' ->
      expect(validator.is-ancestor pipes.pere).to.be.true

    specify 'grand-pere is-ancestor' ->
      expect(validator.is-ancestor pipes.grand-pere).to.be.true

  describe 'validate' ->
    describe 'must take a parent and child Pipes to validate their relationship' ->
      before ->
        validator := new ParentValidator pipe

      context 'no args' ->
        specify 'fails' ->
          expect(-> validator.validate!).to.throw

      context 'same pipe' ->
        before ->
          pipe := new Pipe {}

        specify 'fails' ->
          expect(-> validator.validate pipe).to.throw

      context 'different Pipe' ->
        before ->
          pipes.child := new Pipe 'a', 'b'

        specify 'ok' ->
          expect(validator.validate pipes.child).to.not.throw

      context 'two args: child is ancestor (circular)' ->
        before ->
          pipes.child := new Pipe 'kid'
          pipes.pere := new Pipe 'daddy'
          pipes.grand-pere := new Pipe 'grand daddy'
          pipes.child.parent = pipes.pere
          pipes.pere.parent = pipes.grand-pere
          validator := new ParentValidator pipes.pere

        specify 'cant attach daddy as child to daddy' ->
          expect(-> validator.validate pipes.grand).to.throw

        specify 'cant attach grand daddy as child to daddy' ->
          expect(-> validator.validate pipes.grand-pere).to.throw
