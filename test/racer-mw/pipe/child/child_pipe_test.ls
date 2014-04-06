Class   = require('jsclass/src/core').Class
get     = require '../../../../requires' .get!
expect  = require('chai').expect
get.test 'test_setup'

ChildPipe = get.pipe 'child'



# Should be a Module!
describe 'ChildPipe' ->
  var pipe, child-pipe, parent, res

  describe 'initialize' ->
    specify 'no args - fails' ->
      expect(-> new ChildPipe).to.throw Error

    specify 'String args - ok' ->
      expect(new ChildPipe 'x').to.be.an.instance-of ChildPipe

  context 'instance' ->
    before ->
      pipe    := new ChildPipe 'child'
      parent  := new ContainerPipe 'parent'

    describe 'pre-attach-to(parent)' ->
      # @call-super!
      # @attacher!.attach-to parent
      specify 'attached to parent' ->
        res := child-pipe.pre-attach-to parent
        expect(child-pipe.parent).to.eq parent

    describe 'attacher' ->
      # new ParentAttacher @
      specify 'is a ParentAttacher' ->
        expect(child-pipe.attacher).to.be.an.instance-of ParentAttacher

    describe 'pipes'  ->
      # @api-error 'has parsed pipes'
      specify '-> api error' ->
        expect(-> child-pipe.pipes!).to.throw Error

    describe 'parse' ->
      # @api-error 'can parse pipes'
      specify '-> api error' ->
        expect(-> child-pipe.parse!).to.throw Error

    describe 'add' ->
      # @api-error 'can add pipes'
      specify '-> api error' ->
        expect(-> child-pipe.add!).to.throw Error

    describe 'parser' ->
      # @api-error 'can add pipes'
      specify '-> api error' ->
        expect(-> child-pipe.parser!).to.throw Error
