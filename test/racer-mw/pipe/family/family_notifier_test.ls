Class  = require('jsclass/src/core').Class

requires = require '../../../../requires'

requires.test 'test_setup'

lo = require 'lodash'

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

PipeValue       = requires.pipe   'pipe_value'
PipeFamily      = requires.pipe   'pipe_family'

ModelPipe       = requires.apipe  'model'
CollectionPipe  = requires.apipe  'collection'
AttributePipe   = requires.apipe  'attribute'

Pipe = new Class(
  include:
    * PipeValue
    * PipeFamily
    ...

  type: 'Pipe'
  pipe-type: 'Model'
  parent: void
  child-list: ->
    []

  no-children: ->
    lo.is-empty @child-list!

  value-obj:
    set: (value) ->
      value
)

NoParentPipe = new Class(Pipe,
  parent: void
)

ChildrenNoParentPipe = new Class(NoParentPipe,
  initialize: ->
    @list = []
    @list.push new NoParentPipe
    @

  child-list: ->
    @list
)


HasParentPipe = new Class(Pipe,
  parent: new NoParentPipe
)

ChildrenAndParentPipe = new Class(HasParentPipe,
  initialize: ->
    @list = []
    @list.push new NoParentPipe
    @

  child-list: ->
    @list
)


describe 'FamilyNotifier' ->
  var notifier, pipe
  var col-pipe, modl-pipe, attr-pipe

  create-pipe = (name = 'user') ->
    new ModelPipe name

  fun = {}

  before ->
    /*
    col-pipe    := new CollectionPipe 'users'
    modl-pipe   := col-pipe.models!.add 'user'
    modl-pipe.attributes!.add(name: 'kris').add(email: 'km@gmail.com')
    attr-pipe   := modl-pipe.get 'name'
    */

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

    specify 'is a FamilyNotifier' ->
      expect(notifier).to.be.an.instance-of FamilyNotifier

    specify 'type: Notifier' ->
      expect(notifier.type).to.eql 'Notifier'

    describe 'config-options' ->
      specify 'not-child: true' ->
        expect(notifier.not-child).to.be.true

      specify 'not-parent: true' ->
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

  context 'Pipe: parent and children' ->
    before ->
      pipe     := new ChildrenAndParentPipe
      notifier := new FamilyNotifier pipe
      notifier.notify-family 'z'

    specify 'is a FamilyNotifier' ->
      expect(notifier).to.be.an.instance-of FamilyNotifier

    describe 'config-options' ->
      specify 'not-child: false' ->
        expect(notifier.not-child).to.be.false

      specify 'not-parent: false' ->
        expect(notifier.not-parent).to.be.false

    describe 'notify' ->
      specify 'notify-children: called' ->
        expect(notifier.children-notified).to.be.true

      specify 'notify-parent: called' ->
        expect(notifier.parent-notified).to.be.true

    context 'no-parent: true' ->
      before ->
        notifier := new FamilyNotifier pipe, no-parent: true
        notifier.notify-family 'a'

      specify 'notify-children: not called' ->
        expect(notifier.children-notified).to.be.true

      specify 'notify-parent: not called' ->
        expect(notifier.parent-notified).to.be.false

    context 'no-child: true' ->
      before ->
        notifier := new FamilyNotifier pipe, no-child: true
        notifier.notify-family 'b'

      specify 'notify-children: not called' ->
        expect(notifier.children-notified).to.be.false

      specify 'notify-parent: not called' ->
        expect(notifier.parent-notified).to.be.true

  context 'Pipe: no parent but children' ->
    before ->
      pipe      := new ChildrenNoParentPipe
      notifier  := new FamilyNotifier pipe
      notifier.notify-family 'c'

    specify 'is a FamilyNotifier' ->
      expect(notifier).to.be.an.instance-of FamilyNotifier

    specify 'notify-children: called' ->
      expect(notifier.children-notified).to.be.true

    specify 'notify-parent: not called' ->
      expect(notifier.parent-notified).to.be.false

  context 'Pipe: parent but no children' ->
    before ->
      pipe      := new HasParentPipe
      notifier  := new FamilyNotifier pipe
      notifier.notify-family 'y'

    specify 'is a FamilyNotifier' ->
      expect(notifier).to.be.an.instance-of FamilyNotifier

    specify 'notify-children: not  called' ->
      expect(notifier.children-notified).to.be.false

    specify 'notify-parent: called' ->
      expect(notifier.parent-notified).to.be.true

