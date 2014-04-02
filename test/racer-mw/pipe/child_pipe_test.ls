requires = require '../../../requires'

requires.test 'test_setup'

expect = require('chai').expect

ChildPipe = requires.pipe 'child_pipe'

describe 'ChildPipe' ->
  var pipe

  describe 'initialize' ->

  context 'instance' ->
    before ->
      pipe := new ChildPipe
