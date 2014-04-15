Class   = require('jsclass/src/core').Class
get     = require '../../../../requires' .get!
expect  = require('chai').expect
get.test 'test_setup'

ContainerPipe = get.apipe 'container'

Container = new Class(
  include:
    * ContainerPipe
    ...

  initialize: (...args) ->
    @call-super!
)

# Should be a Module!
describe 'ContainerPipe' ->
  var pipe, args, res, adder

  describe 'initialize' ->
    specify 'no args - fails' ->
      expect(-> new Container).to.throw Error

    specify 'String args - ok' ->
      expect(-> new Container 'x').to.not.throw Error

    specify 'String args - ok' ->
      expect(new Container 'x').to.be.an.instance-of ContainerPipe

  context 'instance' ->
    before ->
      pipe := new Container

    specify 'is a ContainerPipe' ->
      expect(pipe).to.be.an.instance-of ContainerPipe

    describe 'allows-child(type)' ->
      context 'no valid-children' ->
        specify 'model: false' ->
          expect(pipe.allows-child 'model').to.be.false

      context 'valid-children has model' ->
        before ->
          pipe.valid-children = ['model']

        # type in @valid-children
        specify 'model: true' ->
          expect(pipe.allows-child 'model').to.be.true

    describe 'adder' ->
      # new PipeAddHelper @
      before ->
        adder := pipe.adder!

      specify 'is a PipeAddHelper' ->
        expect(adder).to.be.an.instance-of PipeAddHelper

      specify 'has no args' ->
        expect(adder.args).to.be.undefined

    describe 'add(...args)' ->
      # @parse ...args
      context 'x: 2' ->
        before ->
          args := x: 2
          res  := pipe.add args

        specify 'adder has args' ->
          expect(parser.adder!.args).to.eql args

        specify 'parses and returns as model pipe ' ->
          expect(res).to.be.an.instance-of ContainerPipe

        specify 'adds as child model pipe' ->
          expect(pipe.child 0).to.be.an.instance-of ContainerPipe
