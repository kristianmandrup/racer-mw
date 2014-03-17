requires = require '../../../requires'

requires.test 'test_setup'
require 'sugar'

RacerCommand    = requires.racer 'command'
BaseSync        = requires.racer 'sync/base_sync'
RacerSync       = requires.racer 'sync'

expect          = require('chai').expect

describe 'RacerSync' ->
  var command

  describe 'init and validate-args' ->
    context 'no args' ->
      specify 'ok' ->
        expect(-> new RacerSync).to.not.throw Error

      specify 'returns instance' ->
        expect(new RacerSync).to.not.be.undefined

    context 'empty Object arg' ->
      specify 'fails' ->
        expect(-> new RacerSync {}).to.not.throw Error

      specify 'returns instance' ->
        expect(new RacerSync {}).to.not.be.undefined

  describe 'create' ->
    context 'command' ->
      before ->
        command := new RacerCommand {}

      # TODO: huh?
      specify 'fails' ->
        expect(new RacerSync.create command).to.be.an.instance-of BaseSync

