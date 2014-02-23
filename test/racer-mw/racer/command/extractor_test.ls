requires = require '../../../../requires'

requires.test 'test_setup'
require 'sugar'

ArgExtractor  = requires.racer 'command/arg_extractor'

expect        = require('chai').expect

describe 'ArgExtractor' ->
  var extractor
  rules = {}

  describe 'init' ->
    context 'no args' ->
      specify 'fails' ->
        expect(-> new ArgExtractor).to.throw Error

    context '1 obj arg' ->
      specify 'fails' ->
        expect(-> new ArgExtractor {}).to.throw Error

    context '2 obj args' ->
      specify 'creates it' ->
        expect(-> new ArgExtractor {}, {}).to.not.throw Error

  context 'empty instance' ->
    before ->
      extractor := new ArgExtractor {}, {}

    describe 'result-args' ->
      specify 'should initially be empty' ->
        expect(extractor.result-args).to.be.empty

    describe 'extract-optional' ->
      before ->
        extractor.extract-optional!

      specify 'should not add to result-args' ->
        expect(extractor.result-args).to.be.empty

    describe 'extract-required' ->
      before ->
        extractor.extract-required!

      specify 'should not add to result-args' ->
        expect(extractor.result-args).to.be.empty

    describe 'extract' ->
      before ->
        extractor.extract!

      specify 'should not add to result-args' ->
        expect(extractor.result-args).to.be.empty

  context 'rule: push' ->
    before ->
      rules.push =
        required:
          * 'value'
        optional:
          * 'cb'
        result: 'length'

      extractor := new ArgExtractor rules.push, value: 7

    describe 'result-args' ->
      specify 'should initially be empty' ->
        expect(extractor.result-args).to.be.empty

    describe 'extract-optional' ->
      before ->
        extractor.extract-optional!

      specify 'should not add to result-args' ->
        expect(extractor.result-args).to.be.empty

    describe 'extract-required' ->
      before ->
        extractor.extract-required!

      specify 'should not add to result-args' ->
        expect(extractor.result-args).to.not.be.empty

    describe 'extract' ->
      before ->
        extractor.extract!

      specify 'should not add to result-args' ->
        expect(extractor.result-args).to.not.be.empty

      specify 'should add args correctly to result-args' ->
        expect(extractor.result-args.first!).to.equal 7

  context 'rule: push 7, cb' ->
    before ->
      extractor := new ArgExtractor(rules.push, cb: 'x', value: 7)
      extractor.extract!
    specify 'with optional cb, should add and order args correctly' ->
      expect(extractor.result-args.first!).to.equal 7
      expect(extractor.result-args.last!).to.equal 'x'
