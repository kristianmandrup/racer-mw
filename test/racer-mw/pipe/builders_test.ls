Class  = require('jsclass/src/core').Class

requires = require '../../../requires'

requires.test 'test_setup'

expect          = require('chai').expect

PipeBuilders    = requires.pipe 'builders'

SimpleObj = new Class(
)


NoAttachPipe = new Class(
  include: PipeBuilders

  initialize: ->
    @

  attach: void
)


AllPipe = new Class(
  include: PipeBuilders

  initialize: ->
    @

  attach: ->

  valid-children:
    * \attribute
    * \model
    * \collection

  type: 'Pipe'
  pipe-type: 'Path'

  describe: ->
    'I am All'
)

describe 'PipeBuilders' ->
  var pipe, obj

  context 'SimpleObj' ->
    before ->
      pipe := new SimpleObj

    describe 'config-builders function' ->
      specify 'is not present' ->
        expect(pipe.config-builders).to.be.undefined

  context 'NoAttachPipe' ->
    before ->
      pipe := new NoAttachPipe

    describe 'config-builders function' ->
      specify 'is present' ->
        expect(pipe.config-builders).to.not.be.undefined

      specify 'returns void' ->
        expect(pipe.config-builders!).to.eq void


  context 'AllPipe' ->
    before ->
      pipe := new AllPipe

    describe 'config-builders function' ->
      specify 'is present' ->
        expect(pipe.config-builders).to.not.be.undefined

      specify 'returns self' ->
        expect(pipe.config-builders!).to.eq pipe

    context 'configured builders' ->
      before ->
        pipe.config-builders!

      specify 'builders contain the builders' ->
        expect(pipe.builders).to.not.be.empty

