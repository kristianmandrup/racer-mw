Class  = require('jsclass/src/core').Class

requires = require '../../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect
sinon           = require 'sinon'

chai = require "chai"
sinon = require "sinon"
sinon-chai = require "sinon-chai"
# chai.should!
chai.use sinon-chai
expect = chai.expect
chai.use sinon-chai

FamilyNotifier  = requires.pipe   'family/family_notifier'
ModelPipe       = requires.apipe  'model'

describe 'FamilyNotifier' ->
  var notifier, pipe

  create-pipe = (name = 'user') ->
    new ModelPipe name

  fun = {}

  describe 'initialize(@pipe, @options = {})' ->
    specify 'no args: fails' ->
      expect(-> new FamilyNotifier).to.throw Error

    describe 'PipeValidation' ->
      specify 'first arg not a pipe: fails' ->
        expect(-> new FamilyNotifier 'x').to.throw Error

      specify 'first arg is a pipe: ok' ->
        expect(-> new FamilyNotifier create-pipe!).to.not.throw Error

    specify 'is a FamilyNotifier' ->
      expect(new FamilyNotifier create-pipe!).to.be.an.instance-of FamilyNotifier

  context 'instance' ->
    before ->
      pipe     := create-pipe 'user'
      notifier := new FamilyNotifier pipe
      console.log notifier

    specify 'is a FamilyNotifier' ->
      expect(notifier).to.be.an.instance-of FamilyNotifier

    specify 'type: Notifier' ->
      expect(notifier.type).to.eql 'Notifier'

    describe 'config-options' ->
      specify 'not-child - void' ->
        expect(notifier.not-child).to.be.true

      specify 'not-parent' ->
        expect(notifier.not-parent).to.be.true

    describe 'child-list' ->
      specify 'is empty' ->
        expect(notifier.child-list!).to.be.empty

    specify 'notify-children: not called' ->
      expect(notifier.children-notified).to.be.false

    specify 'notify-parent: not called' ->
      expect(notifier.parent-notified).to.be.false

    describe 'notify-family(@updated-value, options = {})' ->
      before ->
        notifier.notify-family 'x'

      specify 'notify-children: not called' ->
        expect(notifier.children-notified).to.be.false

      specify 'notify-parent: not called' ->
        expect(notifier.parent-notified).to.be.false