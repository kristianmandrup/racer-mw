Class  = require('jsclass/src/core').Class

requires = require '../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

PipeFamily    = requires.pipe 'family'

FamilyPipe = new Class(
  include: PipeFamily

  initialize: (@name) ->
    @call-super!
    @
)

util = require 'util'

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

    describe 'child-hash' ->
      specify 'is empty' ->
        expect(pipe.child-hash).to.eql {}

    describe 'clear' ->
      context 'one child' ->
        before ->
          pipe.child-hash = {x: 1}

        specify 'makes children empty' ->
          expect(pipe.clear!.child-hash).to.eql {}

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

    describe 'add-child' ->
      context 'pere adds kid as child' ->
        before ->
          pipes.kid := new FamilyPipe 'kid'
          pipes.sis := new FamilyPipe 'sister'
          pipes.pere := new FamilyPipe 'daddy'
          pipes.sis.add-child 'kiddo', pipes.kid
          pipes.pere.add-child 'kid', pipes.kid
          pipes.pere.add-child 'sis', pipes.sis

          # console.log 'PERE', util.inspect pipes.pere
          # console.log 'KID', util.inspect pipes.kid
          # console.log 'SIS', util.inspect pipes.sis

          # console.log 'PERE children', pipes.pere.child-hash
          # console.log 'KID children', pipes.kid.child-hash
          # console.log 'SIS children', pipes.sis.child-hash

        specify 'pere has only two children' ->
          expect(pipes.pere.child-list!.length).to.eql 2

        specify 'pere has the kid child' ->
          expect(pipes.pere.child 'kid').to.eql pipes.kid

        specify 'kid has no children' ->
          expect(pipes.kid.child-list!.length).to.eql 0

        specify 'sis has one child' ->
          expect(pipes.sis.child-list!.length).to.eql 1

        specify 'kid has empty child hash' ->
          expect(pipes.kid.child-hash).to.eql {}

        specify 'kid has not self as child' ->
          expect(pipes.kid.child 'kid').to.be.undefined

        specify 'kid has pere as parent' ->
          expect(pipes.kid.parent).to.eq pipes.pere

        context 'sis removes child' ->
          var x, kiddo
          before ->
            x := pipes.kiddo
            kiddo := pipes.sis.remove-child 'kiddo'

          specify 'kiddo is gone (garbage collected)' ->
            expect(pipes.kiddo).to.be.undefined

          specify 'x is gone (garbage collected)' ->
            expect(x).to.be.undefined

          specify 'kiddo remains' ->
            expect(kiddo.name).to.eql 'kid'

          specify 'sis has childcount 0' ->
            expect(pipes.sis.child-count).to.eql 0
