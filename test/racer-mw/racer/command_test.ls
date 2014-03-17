requires = require '../../../requires'

requires.test 'test_setup'
require 'sugar'

RacerCommand    = requires.racer 'command'
CommandParser   = requires.racer 'command/parser'

expect          = require('chai').expect

describe 'RacerCommand' ->
  var command

  describe 'init and validate-args' ->
    context 'no args' ->
      specify 'fails' ->
        expect(-> new RacerCommand).to.throw Error

    context 'string arg' ->
      specify 'fails' ->
        expect(-> new RacerCommand 'x').to.throw Error

    context 'Object arg' ->
      specify 'fails' ->
        expect(-> new RacerCommand {}).to.not.throw Error

  context 'RacerCommand instance' ->
    before ->
      command := new RacerCommand {}

    describe 'run' ->
      context 'arg: 7' ->
        specify 'fails' ->
          expect(-> command.run 7).to.throw Error

      context 'arg: push' ->
        specify 'fails' ->
          expect(-> command.run 'push').to.not.throw Error

    describe 'command-parser' ->
      context 'arg: 7' ->
        specify 'fails' ->
          expect(-> command.command-parser 7).to.throw Error

      context "arg: {value: 'x'}" ->
        specify 'returns CommandParser instance' ->
          expect(command.command-parser value: 'x').to.be.an.instance-of CommandParser

    describe 'with' ->
      context 'arg: 7' ->
        specify 'fails' ->
          expect(-> command.using 7).to.throw Error

      context "arg: value: 'x'" ->
        specify 'return list with 7' ->
          expect(command.using(value: 'x').first!).to.equal 'x'
