get     = require '../../../requires' .get!
expect  = require('chai').expect
get.test 'test_setup'

ContainerPipe = get.pipe 'container'

# Should be a Module!
describe 'ContainerPipe' ->
  var pipe

  describe 'initialize' ->
    specify 'no args - fails' ->
      expect(-> new ContainerPipe).to.throw Error

    specify 'String args - ok' ->
      expect(new ContainerPipe 'x').to.be.an.instance-of ContainerPipe

  context 'instance' ->
    before ->
      pipe := new ContainerPipe
