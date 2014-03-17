requires = require '../../../../requires'

requires.test 'test_setup'
require 'sugar'

RacerCommand    = requires.racer 'command'
MwSync          = requires.racer 'sync/mw_sync'

expect          = require('chai').expect

describe 'MwSync' ->
  var command

  describe 'init and validate-args' ->
    context 'no args' ->
      specify 'fails' ->
        expect(-> new MwSync).to.throw Error

    context 'empty Object arg' ->
      specify 'fails' ->
        expect(-> new MwSync {}).to.throw Error


    context 'racer-command arg' ->
      before ->
        command := new RacerCommand {}

      # TODO: huh?
      specify 'fails' ->
        expect(new MwSync command).to.be.undefined

