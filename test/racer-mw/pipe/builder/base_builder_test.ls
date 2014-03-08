requires = require '../../../../requires'

requires.test 'test_setup'

expect            = require('chai').expect

PathPipe          = requires.apipe 'path'
BasePipeBuilder   = requires.apipe-builder 'base'

describe 'BasePipeBuilder' ->
  var pipe, obj

  describe 'init' ->
    context 'no args' ->
      specify 'fails - must take an object that can attach' ->
        expect(-> new BasePipeBuilder).to.throw

  context 'Path pipe' ->
    before ->
      pipe := new PathPipe '_path'

    describe 'init' ->
      specify 'pass pipe - success' ->
        expect(-> new BasePipeBuilder pipe).to.not.throw
