Class  = require('jsclass/src/core').Class

requires = require '../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

_ = require 'prelude-ls'

PipeInspector   = requires.pipe 'inspector'

NoInfoPipe = new Class(
  include: PipeInspector

  initialize: ->
    @

  child-names: ->
    _.keys(@child-hash)

  child-hash: void
)

InfoPipe = new Class(
  include: PipeInspector

  initialize: ->
    @

  child-hash: {}

  child-names: ->
    _.keys(@child-hash)


  type: 'Pipe'
  pipe-type: 'Path'
)

ChildrenPipe = new Class(
  include: PipeInspector

  initialize: ->
    @

  child-hash: {
    'x':
      pipe-type: 'Model'
      describe: ->
        'x'
    'y':
      pipe-type: 'Attribute'
      describe: ->
        'y'
  }

  child-names: ->
    _.keys(@child-hash)

  child: (name) ->
    @child-hash[name]

  type: 'Pipe'
  pipe-type: 'Path'
)


describe 'PipeInspector' ->
  var pipe, obj

  context 'NoInfoPipe' ->
    before ->
      pipe := new NoInfoPipe

    describe 'describe function' ->
      specify 'is present' ->
        expect(pipe.describe).to.not.be.undefined

      specify 'returns void' ->
        expect(pipe.describe!).to.eql { type: undefined, name: undefined, id: undefined, value: undefined, children: 0 }

    describe 'describe-children' ->
      specify 'to show obj' ->
        expect(pipe.describe-children!).to.eql 'no children'

  context 'InfoPipe' ->
    before ->
      pipe := new InfoPipe

    describe 'describe function' ->
      specify 'is present' ->
        expect(pipe.describe).to.not.be.undefined

      specify 'returns type: Path' ->
        expect(pipe.describe!).to.eql { type: 'Path', name: undefined, id: undefined, value: undefined, children: 0 }

    describe 'describe-children' ->
      specify 'to show obj' ->
        expect(pipe.describe-children!).to.eql 'no children'

  context 'ChildrenPipe' ->
    before ->
      pipe := new ChildrenPipe

    describe 'describe function' ->
      specify 'is present' ->
        expect(pipe.describe!).to.eql { type: 'Path', name: undefined, id: undefined, value: undefined, children: 2 }

    describe 'describe-children' ->
      specify 'to show list of children desc: x, y' ->
        expect(pipe.describe-children!).to.eql [ 'x', 'y' ]

    describe 'child-types' ->
      specify 'to show list of children desc: x, y' ->
        expect(pipe.child-types!).to.eql [ 'Model', 'Attribute' ]
