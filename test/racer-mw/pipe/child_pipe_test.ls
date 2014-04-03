get = require '../../../requires' .get!

get.test 'test_setup'

expect = require('chai').expect

ChildPipe = get.pipe 'child'

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
