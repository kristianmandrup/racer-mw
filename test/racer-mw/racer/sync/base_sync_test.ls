requires = require '../../../../requires'

requires.test 'test_setup'
require 'sugar'

RacerCommand    = requires.racer 'command'
BaseSync        = requires.racer 'sync/base_sync'

expect          = require('chai').expect

describe 'BaseSync' ->
  var command

  describe 'init and validate-args' ->
    context 'no args' ->
      specify 'fails' ->
        expect(-> new BaseSync).to.throw Error

    context 'empty Object arg' ->
      specify 'fails' ->
        expect(-> new BaseSync {}).to.throw Error


    context 'racer-command arg' ->
      before ->
        command := new RacerCommand {}

      # TODO: huh?
      specify 'fails' ->
        expect(new BaseSync command).to.be.undefined

