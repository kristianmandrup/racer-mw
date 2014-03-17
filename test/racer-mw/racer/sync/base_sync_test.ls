requires = require '../../../../requires'

requires.test 'test_setup'
require 'sugar'

RacerCommand    = requires.racer 'command'
BaseSync        = requires.racer 'sync/base_sync'

ModelPipe       = requires.apipe     'model'
ModelResource   = requires.aresource 'model'

expect          = require('chai').expect

describe 'BaseSync' ->
  var command, pipe, resource

  describe 'init and validate-args' ->
    context 'no args' ->
      specify 'fails' ->
        expect(-> new BaseSync).to.throw Error

    context 'empty Object arg' ->
      specify 'fails' ->
        expect(-> new BaseSync {}).to.throw Error


    context 'racer-command' ->
      specify 'empty - fails' ->
        expect(-> new BaseSync(new RacerCommand {})).to.throw

      context 'with resource' ->
        before ->
          pipe      := new ModelPipe 'user'
          resource  := new ModelResource pipe: pipe
          command   := new RacerCommand(resource)

        specify 'missing action - fails' ->
          expect(-> new BaseSync(command)).to.throw

        context 'and action' ->
          before ->
            command   := new RacerCommand(resource).run('path')

          specify 'is ok' ->
            expect(new BaseSync(command)).to.be.an.instance-of BaseSync
