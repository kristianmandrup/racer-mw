requires = require '../../../../requires'

requires.test 'test_setup'

ArgExtractor  = requires.racer 'command/arg_extractor'

expect        = require('chai').expect

describe 'ArgExtractor' ->
  var extractor

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
