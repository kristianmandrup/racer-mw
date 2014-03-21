requires = require '../../../../requires'

requires.test 'test_setup'
require 'sugar'

CommandParser   = requires.racer 'command/racer_command_parser'
ArgStore        = requires.resource 'arg/resource_arg_store'
ArgExtractor    = requires.racer 'command/racer_command_arg_extractor'

expect          = require('chai').expect

describe 'CommandParser' ->
  var parser

  describe 'init and validate-args' ->
    context 'no args' ->
      specify 'fails' ->
        expect(-> new CommandParser).to.throw Error

    context '1 string arg' ->
      specify 'fails' ->
        expect(-> new CommandParser 'x').to.throw Error

    context '2 string args' ->
      specify 'fails' ->
        expect(-> new CommandParser 'x', 'y').to.throw Error

    context 'valid args: string, object' ->
      specify 'ok' ->
        expect(-> new CommandParser 'x', {y: 'y'}).to.not.throw Error

  context 'CommandParser instance' ->
    before ->
      parser := new CommandParser 'x', {y: 'y'}

    describe 'command-map' ->
      specify 'has one' ->
        expect(parser.command-map).to.be.an.instance-of Object

    describe 'command-rule' ->
      specify 'invalid rule name throws Error' ->
        expect( -> parser.command-rule 'unknown').to.throw Error

      specify 'valid rule name returns rule obj' ->
        expect(parser.command-rule 'push').to.be.an.instance-of Object

    describe 'rule' ->
      specify 'invalid rule name throws Error' ->
        expect(-> parser.rule!).to.throw Error

    describe 'extractor' ->
      specify 'invalid rule name throws Error' ->
        expect(-> parser.extractor!).to.throw Error

      context 'valid rule name: push' ->
        before ->
          parser := new CommandParser 'push', {y: 'y'}

        specify 'returns an ArgExtractor' ->
          expect(parser.extractor!).to.be.an.instance-of ArgExtractor

    describe 'extract' ->
      specify 'invalid rule name throws Error' ->
        expect(-> parser.extract!).to.throw Error

      context 'valid rule name: push, invalid args' ->
        before ->
          parser := new CommandParser 'push', {y: 'y'}

        specify 'fails since missing value argument' ->
          expect(-> parser.extract!).to.throw

      context 'valid rule name: push, valid required arg: value' ->
        before ->
          parser := new CommandParser 'push', {value: '3'}

        specify 'ok' ->
          expect(-> parser.extract!).to.not.throw

        specify 'returns array of extracted args: 3' ->
          expect(parser.extract!.first!).to.equal '3'