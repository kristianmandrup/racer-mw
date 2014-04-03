get = require '../../../requires' .get!

get.test 'test_setup'

expect = require('chai').expect

ContainerPipe = get.pipe 'container'

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
