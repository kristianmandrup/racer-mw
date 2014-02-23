requires = require '../../../../requires'

requires.test 'test_setup'
require 'sugar'

CommandParser  = requires.racer 'command/parser'

expect        = require('chai').expect

describe 'CommandParser' ->
  var parser

  describe 'init' ->
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
