Class  = require('jsclass/src/core').Class

requires = require '../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

argumentor = requires.pipe 'argumentor'

describe 'Argumentor' ->
  var first, all, valid

  describe 'extract' ->
    context 'void' ->
      specify 'throws' ->
        expect(-> argumentor.extract!).to.throw

  describe 'extract' ->
    context 'no args' ->
      specify 'throws' ->
        expect(-> argumentor.extract []).to.throw

  describe 'extract' ->
    context 'one string: a' ->
      before ->
        [first, all] := argumentor.extract ['a']

      specify 'first: a' ->
        expect(first).to.eql 'a'

      specify 'all: a,b' ->
        expect(all).to.eql 'a'

  describe 'extract' ->
    context 'object' ->
      before ->
        [first, all] := argumentor.extract [a: 1]

      specify 'first: a' ->
        expect(first).to.eql a: 1

      specify 'all: a,b' ->
        expect(all).to.eql a: 1

  describe 'extract' ->
    context 'list of strings: a, b' ->
      before ->
        [first, all] := argumentor.extract ['a', 'b']

        specify 'first: a' ->
          expect(first).to.eql 'a'

        specify 'all: a,b' ->
          expect(all).to.eql ['a', 'b']

  describe 'extract' ->
    context 'named object' ->
      before ->
        [first, all] := argumentor.extract x: [a: 1]

        specify 'first: a' ->
          expect(first).to.eql x: [a: 1]

        specify 'all: a,b' ->
          expect(all).to.eql x: [a: 1]
