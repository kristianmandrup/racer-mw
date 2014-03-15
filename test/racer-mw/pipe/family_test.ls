Class  = require('jsclass/src/core').Class

requires = require '../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

PipeFamily    = requires.pipe 'family'

FamilyPipe = new Class(
  include: PipeFamily

  initialize: ->
    @
)

describe 'PipeFamily' ->
  var pipe, obj

  pipes = {}

  context 'NoInfoPipe' ->
    before ->
      pipe := new FamilyPipe

    describe 'ancestors' ->
      specify 'is present' ->
        expect(pipe.ancestors).to.not.be.undefined

      specify 'returns empty' ->
        expect(pipe.ancestors!).to.eql []

    describe 'child' ->
      specify 'no args: void' ->
        expect(pipe.child!).to.eql void

      specify 'unknown child: void' ->
        expect(pipe.child 'x').to.eql void

    describe 'parent-name' ->
      specify 'no args: void' ->
        expect(pipe.parent-name!).to.eql ''

    describe 'valid-parents' ->
      specify 'is empty' ->
        expect(pipe.valid-parents).to.eql []

    describe 'parents' ->
      specify 'is void' ->
        expect(pipe.parent).to.eql void

    describe 'children' ->
      specify 'is empty' ->
        expect(pipe.children).to.eql {}

    describe 'clear' ->
      context 'one child' ->
        before ->
          pipe.children = {x: 1}

        specify 'makes children empty' ->
          expect(pipe.clear!.children).to.eql {}

    describe 'ancestors' ->
      context 'family' ->
        before ->
          pipes.child := new FamilyPipe 'kid'
          pipes.pere := new FamilyPipe 'daddy'
          pipes.grand-pere := new FamilyPipe 'grand daddy'
          pipes.child.parent = pipes.pere
          pipes.pere.parent = pipes.grand-pere

        specify 'grand-pere is a child ancestor' ->
          expect(pipes.grand-pere in pipes.child.ancestors!).to.be.true

        specify 'grand-pere is a parent ancestor' ->
          expect(pipes.grand-pere in pipes.pere.ancestors!).to.be.true
