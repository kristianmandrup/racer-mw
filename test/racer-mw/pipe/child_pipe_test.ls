get     = require '../../../requires' .get!
expect  = require('chai').expect
get.test 'test_setup'

ChildPipe = get.pipe 'child'

# Should be a Module!
describe 'ChildPipe' ->
  var pipe

  describe 'initialize' ->
    specify 'no args - fails' ->
      expect(-> new ChildPipe).to.throw Error

    specify 'String args - ok' ->
      expect(new ChildPipe 'x').to.be.an.instance-of ChildPipe

  context 'instance' ->
    before ->
      pipe := new ChildPipe
