requires = require '../../../../requires'

requires.test 'test_setup'
require 'sugar'

RacerCommand    = requires.racer 'racer_command'
BaseSync        = requires.racer 'sync/racer_base_sync'

ModelPipe       = requires.apipe     'model'
CollectionPipe  = requires.apipe     'collection'

ModelResource   = requires.aresource 'model'

expect          = require('chai').expect

describe 'BaseSync' ->
  var command, pipe, resource, value, sync

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
          pipe      := new CollectionPipe('users')
          pipe.models!.add 'user'

          resource  := new ModelResource pipe: pipe
          command   := new RacerCommand(resource)

        specify 'missing action - fails' ->
          expect(-> new BaseSync(command)).to.throw

        context 'and action' ->
          before ->
            command   := new RacerCommand(resource).run('path')

          specify 'is ok' ->
            expect(new BaseSync(command)).to.be.an.instance-of BaseSync

  context 'BaseSync instance' ->
    before ->
      pipe      := new ModelPipe 'user'
      resource  := new ModelResource pipe: pipe

    context 'action: path' ->
      before ->
        command   := new RacerCommand(resource).run('path')
        sync      := new BaseSync(command)

      describe 'command-name' ->
        specify 'is action of RacerCommand: path' ->
          expect(sync.command-name!).to.eq 'path'

      describe 'command-args' ->
        specify 'is command-args of RacerCommand' ->
          expect(sync.command-args!).to.eq command.command-args

        specify 'is undefined' ->
          expect(sync.command-args!).to.be.undefined

      xdescribe 'execute' ->
        specify 'executes command on Racer = x' ->
          expect(sync.execute!).to.eq 'x'

    context 'action: set value' ->
      before ->
        value     := {name: 'emma'}
        command   := new RacerCommand(resource).run('set').using value: value
        sync      := new BaseSync(command)
        sync.racer-store.init(
          users: [
            {name: 'kris'}
          ]
        )

      describe 'command-name' ->
        specify 'is action of RacerCommand: path' ->
          expect(sync.command-name!).to.eq command.action

      describe 'command-args' ->
        specify 'is command-args of RacerCommand' ->
          expect(sync.command-args!).to.eq command.command-args

        specify 'is a list' ->
          expect(sync.command-args!).to.eql [ value ]

      describe 'execute' ->
        specify 'executes command on Racer = x' ->
          expect(sync.execute!).to.throw
