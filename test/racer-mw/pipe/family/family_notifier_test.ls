Class  = require('jsclass/src/core').Class

requires = require '../../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

FamilyNotifier  = requires.pipe   'family/family_notifier'
ModelPipe       = requires.apipe  'model'

describe 'FamilyNotifier' ->
  var notifier, pipe

  create-pipe = (name = 'user') ->
    new ModelPipe name

  describe 'initialize(@pipe, @options = {})' ->
    specify 'no args: fails' ->
      expect(-> new FamilyNotifier).to.throw Error

    describe 'PipeValidation' ->
      specify 'first arg not a pipe: fails' ->
        expect(-> new FamilyNotifier 'x').to.throw Error

      specify 'first arg is a pipe: ok' ->
        expect(-> new FamilyNotifier create-pipe!).to.not.throw Error

  context 'instance' ->
    before ->
      pipe     := create-pipe 'user'
      notifier := new FamilyNotifier pipe

    describe 'config-options' ->
      specify 'not-child' ->
      specify 'not-parent' ->

    describe 'child-list' ->


    describe 'notify-family(@updated-value, options = {})' ->

    describe 'notify-children' ->

    describe 'notify-parent' ->