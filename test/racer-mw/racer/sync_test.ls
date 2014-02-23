requires = require '../../../requires'

requires.test 'test_setup'
require 'sugar'

RacerCommand    = requires.racer 'command'
RacerSync       = requires.racer 'sync'

expect          = require('chai').expect

describe 'RacerSync' ->
  var command

  describe 'init and validate-args' ->
    context 'no args' ->
      specify 'fails' ->
        expect(-> new RacerSync).to.throw Error

    context 'empty Object arg' ->
      specify 'fails' ->
        expect(-> new RacerSync {}).to.throw Error


    context 'racer-command arg' ->
      before ->
        command := new RacerCommand {}

      specify 'fails' ->
        expect(new RacerSync command).to.be.undefined

