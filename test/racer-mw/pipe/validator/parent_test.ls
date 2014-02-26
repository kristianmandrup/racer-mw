requires = require '../../../../requires'

requires.test 'test_setup'

Pipe              = requires.pipe 'base'
ParentValidator   = requires.pipe 'validator/parent'

expect      = require('chai').expect

describe 'Pipe ParentValidator' ->
  var pipe, validator

  pipes = {}

  describe 'init' ->
    describe 'must take an array of valid types to validate pipes against' ->
    context 'no args' ->
      specify 'fails' ->
        expect(-> new ParentValidator).to.throw

    context 'two args' ->
      specify 'succeess' ->
        expect(-> new ParentValidator 'x', 'y').to.not.throw

    context 'array' ->
      specify 'succeess' ->
        expect(-> new ParentValidator []).to.not.throw

  describe 'validate' ->
    describe 'must take a parent and child Pipes to validate their relationship' ->
      before ->
        validator := new ParentValidator []
      context 'no args' ->
        specify 'fails' ->
          expect(-> validator.validate!).to.throw

      context 'one arg: String' ->
        specify 'fails' ->
          expect(-> validator.validate 'x').to.throw

      context 'one args: pipe' ->
        before ->
          pipe := new Pipe {}

        specify 'fails' ->
          expect(-> validator.validate pipe).to.throw

      context 'two args: Strings' ->
        specify 'fails' ->
          expect(-> validator.validate 'x', 'y').to.throw

      context 'two args: same Pipes' ->
        before ->
          pipe := new Pipe 'x', 'y'

        specify 'fails - never allow same pipe comparison' ->
          expect(-> validator.validate pipe, pipe).to.throw

      context 'two args: different Pipes' ->
        before ->
          pipes.parent := new Pipe 'x', 'y'
          pipes.child := new Pipe 'a', 'b'

        specify 'ok' ->
          expect(validator.validate pipes.parent, pipes.child).to.not.throw
